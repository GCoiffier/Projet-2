open Fouine_type
open Environnement

type instruction =
		INT of int
		| ADD | MINUS | MULT | DIV | MOD
		| AND | OR
		| EQUAL | NEQUAL | INFEQ | INF | SUPEQ | SUP
		| UMINUS | PRINT
		| POP
		
		| LET of string |ENDLET |ACCESS of string
		
		| IF of instruction list * instruction list
		
		| FUNCT of instruction list
		| CALL | RETURN

module type StackMachineSig = sig
	type machine

	val init : programme -> machine ref
	(* builds a stack machine out of a fouine program *)

	val display : machine ref -> string
	(* returns a string representing the stack of instructions*)

	val step : machine ref -> unit
	(* executes the instruction on top of the stack *)

	val compute : instruction list -> int

	val init_and_compute : programme -> int
	(* inits a machine and execute every instruction, then print out the result *)

	val init_and_display : programme -> string
	(* inits a machine and returns its stack of instruction*)
	
	val mach_empty : machine ref -> bool

end

module StackMachine : StackMachineSig = struct

	type environnement =
		(string * mach_type) list

	and  mach_type =
		VAL of int
		| FUN  of environnement * instruction list
		| ENV  of environnement
		| INST of instruction list

	type machine =
		Mach of instruction list * environnement * mach_type list

	let rec built p_ l = match p_ with
		| Const(i) 				 -> INT(i)::l
  		| Var(v) 				 -> ACCESS(v)::l
  		| PrInt(p) 				 -> (built p (PRINT::l))
  		| Imp(a,b) 				 -> (built a (POP::(built b l)))
  		
    	| UnOp(Neg,p) 		 	 -> (built p (UMINUS::l))
    	| BinOp(p1,Add,p2)   	 -> (built p1 (built p2 (ADD::l)))
    	| BinOp(p1,Minus,p2) 	 -> (built p1 (built p2 (MINUS::l)))
    	| BinOp(p1,Mult,p2)  	 -> (built p1 (built p2 (MULT::l)))
    	| BinOp(p1,Div,p2)   	 -> (built p1 (built p2 (DIV::l)))
    	| BinOp(p1,Mod,p2)   	 -> (built p1 (built p2 (MOD::l)))
    	| BinOp(p1,Equal,p2) 	 -> (built p1 (built p2 (EQUAL::l)))
    	| BinOp(p1,Neq,p2)   	 -> (built p1 (built p2 (NEQUAL::l)))
    	| BinOp(p1,Infeq,p2) 	 -> (built p1 (built p2 (INFEQ::l)))
    	| BinOp(p1,Inf,p2)   	 -> (built p1 (built p2 (INF::l)))
    	| BinOp(p1,Supeq,p2) 	 -> (built p1 (built p2 (SUPEQ::l)))
    	| BinOp(p1,Sup,p2)   	 -> (built p1 (built p2 (SUP::l)))
    	| BinOp(p1,And,p2)   	 -> (built p1 (built p2 (AND::l)))
    	| BinOp(p1,Or,p2)    	 -> (built p1 (built p2 (OR::l)))
    	
    	| Let(Var(x),a,b) 		 -> built a (LET(x)::(built b (ENDLET::l))) (* let x = A in B  : (x,A,B) *)
    	
    	| IfThenElse(x,a,b) 	 -> built x (IF(built a [], built b [])::l) (* if x then A else B : (x,A,B) *)
    	
    	| Function_def(Var(x),b) -> FUNCT(LET(x)::(built b [RETURN]))::l
    	| Function_call(a,b) 	 -> built a (built b (CALL::l))
    	
    	| _ -> failwith "not implement in machine"

	let init p = ref (Mach( built p [], [], []))

	let rec find env x = match env with (* trouve la variable dans l'environnement : s'arrête au plus récent *)
		|[] -> failwith "variable not found"
		|(v,t)::q when v=x -> t
		|t::q -> find q x

	let display machine =
		let rec print_instr_list = function
			|[] -> ""
			|t::q ->
			( match t with
				  INT(i) 	-> (string_of_int i)^";\n"
				| ADD		-> "ADD;\n"
				| MINUS 	-> "MINUS;\n"
				| MULT 		-> "MULT;\n"
				| DIV 		->  "DIV;\n"
				| MOD 		-> "MOD;\n"
				| UMINUS 	-> "UMINUS;\n"
				| PRINT 	-> "PRINT;\n"
				| POP 		-> "POP;\n"

				| LET(x) 	-> "LET("^x^");\n"
				| ENDLET 	-> "ENDLET;\n"
				| ACCESS(x) -> "ACCESS("^x^");\n"

				| IF(a,b) 	-> "IF;\n"^(print_instr_list a)^"ELSE;\n"^(print_instr_list b)^"IFEND;\n";
				
				| AND    	-> "AND;\n"
				| OR     	-> "OR;\n"
				| EQUAL  	-> "EQUAL;\n"
				| NEQUAL 	-> "NEQUAL;\n"
				| INFEQ  	-> "INFEQ;\n"
				| INF    	-> "INF;\n"
				| SUPEQ  	-> "SUPEQ;\n"
				| SUP    	-> "SUP;\n"
				
				| FUNCT(c) 	-> "FUNCT;\n"^(print_instr_list c)
				| RETURN 	-> "RETURN;\n"
				| CALL 		-> "CALL;\n"

				)^(print_instr_list q)
		in match (!machine) with Mach(l,_,_) -> (print_instr_list l)^";;"

	let step machine =
		match !machine with
		| Mach(t::q,env,l) ->(
					match t with
					|INT(i) 	-> machine := Mach(q,env,VAL(i)::l);
					|UMINUS 	-> (match l with
									|[] -> failwith "stack empty"
									|VAL(ti)::qi -> machine := Mach(q,env, VAL(-ti)::qi)
									| _ -> failwith "top object has not an int"
							  	 )
					|PRINT 		-> (match l with
									|[] -> failwith "stack empty"
									|VAL(ti)::qi -> print_int ti; print_newline(); machine := Mach(q,env,l)
									| _ -> failwith "top object has not an int"
							   	 )
					|POP 		-> (match l with
									|[] -> failwith "stack empty"
									|ti::qi -> machine := Mach(q,env,qi)
								 )		   
							   

					|LET(x) 	-> (match l with
									|[] -> failwith "stack empty"
									|ti::qi -> machine := Mach(q, (x,ti)::env ,qi)
						  	     )
					|ENDLET 	-> (match env with
									|[] -> failwith "environnement empty"
									|(x,ti)::qi -> machine := Mach(q, qi ,l)
							     )
					|ACCESS(x) 	-> machine := Mach(q, env , (find env x)::l)
					
					

					|IF(a,b) 	-> (match l with
									|[] -> failwith "stack empty"
									|VAL(ti)::qi -> if ti=0 then machine := Mach(b@q, env ,qi)
											   else machine := Mach(a@q, env ,qi)
									| _ -> failwith "top object has not an int"
						   		 )
						   
						   
						   
					|FUNCT(c) 	-> machine := Mach(q, env , FUN(env,c)::l)
					|CALL 		-> (match l with
									|[] -> failwith "stack empty"
									|ti::FUN(envf, cf)::qi -> machine := Mach(cf,envf, ti::ENV(env)::INST(q)::qi)
									| _ -> failwith "top of stack has not the good object"
							     )   
					|RETURN 	-> (match l with
									|[] -> failwith "stack empty"
									|ti::ENV(env)::INST(c)::qi -> machine := Mach(c,env, ti::qi)
									| _ -> failwith "top of stack has not the good object"
								 )
								

					|_ ->      (match l with
								|VAL(t2)::VAL(t1)::qi -> (let c0 = ref 0 in match t with
												|ADD -> machine := Mach(q,env, VAL(t1+t2)::qi)
												|MINUS -> machine := Mach(q,env, VAL(t1-t2)::qi)
												|MULT -> machine := Mach(q,env, VAL(t1*t2)::qi)
												|DIV -> machine := Mach(q,env, VAL(t1/t2)::qi)
												|MOD -> machine := Mach(q,env, VAL(t1 mod t2)::qi)

												|NEQUAL -> (if t1!=t2 then c0 := 1 else c0 := 0 );
														machine := Mach(q,env, VAL(!c0)::qi)
												|EQUAL  -> (if t1=t2  then c0 := 1 else c0 := 0 );
														machine := Mach(q,env, VAL(!c0)::qi)
												|INFEQ  -> (if t1<=t2 then c0 := 1 else c0 := 0 );
														machine := Mach(q,env, VAL(!c0)::qi)
												|INF    -> (if t1<t2  then c0 := 1 else c0 := 0 );
														machine := Mach(q,env, VAL(!c0)::qi)
												|SUPEQ  -> (if t1>=t2 then c0 := 1 else c0 := 0 );
														machine := Mach(q,env, VAL(!c0)::qi)
												|SUP    -> (if t1>t2  then c0 := 1 else c0 := 0 );
														machine := Mach(q,env, VAL(!c0)::qi)

												|AND -> machine := Mach(q,env, VAL(t1*t2)::qi);
												|OR  -> machine := Mach(q,env, VAL(t1+t2)::qi);
												|_ -> ()
											  )
								|_ -> failwith "stack empty"
							   )
				)
		| _ -> failwith "execution failed"

	let mach_empty machine =
		match !machine with
			| Mach([],_,_) -> true
			| _ 		   -> false
	
	let compute prg =
		let mach = ref (Mach(prg,[],[])) in
		while not(mach_empty mach)
			do step mach
		done;
		match !mach with
		 | Mach([],_,VAL(t)::[]) -> t
		 | _ 					 -> failwith "execution failed : end value not an int or too much end values"

	let init_and_compute prg =
		let mach = init prg in
		while not(mach_empty mach)
			do step mach
		done;
		match !mach with
		 | Mach([],_,VAL(t)::[]) -> t
		 | _ 					 -> failwith "execution failed : end value not an int or too much end values"

	let init_and_display prg =
		let mach = init prg in
			display mach

end
