open Fouine_type
open Environnement

module type StackMachineSig = sig
	type machine

	val init : programme -> machine ref
	(* builds a stack machine out of a fouine program *)

	val display : machine ref -> string
	(* returns a string representing the stack of instructions*)

	val step : machine ref -> bool
	(* executes the instruction on top of the stack *)

	val init_and_compute : programme -> unit
	(* inits a machine and execute every instruction, then print out the result *)

	val init_and_display : programme -> string
	(* inits a machine and returns its stack of instruction*)

end



module StackMachine : StackMachineSig = struct

	type environnement =
		(string * int) list

	type instruction =
		INT of int
		| ADD | MINUS | MULT | DIV | MOD
		| AND | OR
		| EQUAL | NEQUAL | INFEQ | INF | SUPEQ | SUP
		| UMINUS | PRINT
		| LET of string |ENDLET |ACCESS of string
		| IF of instruction list * instruction list

	type machine =
		Mach of instruction list * environnement * int list

	let rec build p_ l = match p_ with
		 Unit -> failwith "not implement in machine"
		| Const(i) -> (INT(i))::l
  		| Var(v) -> ACCESS(v)::l
  		| PrInt(p) -> (build p (PRINT::l))
    	| UnOp(Neg,p) -> (build p (UMINUS::l))
    	| BinOp(p1,Add,p2)   -> (build p1 (build p2 (ADD::l)))
    	| BinOp(p1,Minus,p2) -> (build p1 (build p2 (MINUS::l)))
    	| BinOp(p1,Mult,p2)  -> (build p1 (build p2 (MULT::l)))
    	| BinOp(p1,Div,p2)   -> (build p1 (build p2 (DIV::l)))
    	| BinOp(p1,Mod,p2)   -> (build p1 (build p2 (MOD::l)))
    	| BinOp(p1,Equal,p2) -> (build p1 (build p2 (EQUAL::l)))
    	| BinOp(p1,Neq,p2)   -> (build p1 (build p2 (NEQUAL::l)))
    	| BinOp(p1,Infeq,p2) -> (build p1 (build p2 (INFEQ::l)))
    	| BinOp(p1,Inf,p2)   -> (build p1 (build p2 (INF::l)))
    	| BinOp(p1,Supeq,p2) -> (build p1 (build p2 (SUPEQ::l)))
    	| BinOp(p1,Sup,p2)   -> (build p1 (build p2 (SUP::l)))
    	| BinOp(p1,And,p2)   -> (build p1 (build p2 (AND::l)))
    	| BinOp(p1,Or,p2)    -> (build p1 (build p2 (OR::l)))
    	| Let(Var(x),a,b) -> build a (LET(x)::(build b (ENDLET::l))) (* let x = A in B  : (x,A,B) *)
    	| IfThenElse(x,a,b) -> build x (IF(build a [], build b [])::l) (* if x then A else B : (x,A,B) *)
    	| _ -> failwith "not implement in machine"

	let init p = ref (Mach( build p [], [], []))


	let rec find env x = match env with (* trouve la variable dans l'environnement : s'arrête au plus récent *)
		|[] -> failwith "environnement empty"
		|(v,t)::q when v=x -> t
		|t::q -> find q x

	let display machine =
		let rec print_instr_list = function
			|[] -> ""
			|t::q ->
			( match t with
				  INT(i) -> (string_of_int i)^";\n"
				| ADD -> "ADD;\n"
				| MINUS -> "MINUS;\n"
				| MULT -> "MULT;\n"
				| DIV ->  "DIV;\n"
				| MOD -> "MOD;\n"
				| UMINUS -> "UMINUS;\n"
				| PRINT -> "PRINT;\n"

				| LET(x) -> "LET("^x^");\n"
				| ENDLET -> "ENDLET;\n"
				| ACCESS(x) -> "ACCESS("^x^");\n"

				| IF(a,b) -> "IF;\n"^(print_instr_list a)^"ELSE;\n"^(print_instr_list b)^"IFEND;\n";
				| AND    -> "AND;\n"
				| OR     -> "OR;\n"
				| EQUAL  -> "EQUAL;\n"
				| NEQUAL -> "NEQUAL;\n"
				| INFEQ  -> "INFEQ;\n"
				| INF    -> "INF;\n"
				| SUPEQ  -> "SUPEQ;\n"
				| SUP    -> "SUP;\n"
				)^(print_instr_list q)
		in match (!machine) with Mach(l,_,_) -> (print_instr_list l)^";;"

	let step machine =
		match !machine with
		  Mach([],_,t::[]) -> print_string "- Result = "; print_int t; print_newline(); true
		| Mach(t::q,env,l) ->(
					match t with
					|INT(i) -> machine := Mach(q,env,i::l); false
					|UMINUS -> (match l with
								|[] -> failwith "stack empty"
								|ti::qi -> machine := Mach(q,env, (-ti)::qi) ; false
							   )
					|PRINT ->  (match l with
								|[] -> failwith "stack empty"
								|ti::qi -> print_int ti; print_newline(); machine := Mach(q,env,l) ; false
							   )

					|LET(x) -> (match l with
								|[] -> failwith "stack empty"
								|ti::qi -> machine := Mach(q, (x,ti)::env ,qi) ; false
						  	   )

					|ENDLET -> (match env with
								|[] -> failwith "environnement empty"
								|(x,ti)::qi -> machine := Mach(q, qi ,l) ; false
							   )

					|ACCESS(x) -> machine := Mach(q, env , (find env x)::l) ; false

					|IF(a,b) -> (match l with
							|[] -> failwith "environnement empty"
							|ti::qi -> if ti=0 then machine := Mach(b@q, env ,qi)
											   else machine := Mach(a@q, env ,qi) ;
							false
						   )

					|_ ->      (match l with
								|t2::t1::qi -> (let c0 = ref 0 in match t with
												|ADD -> machine := Mach(q,env, (t1+t2)::qi); false
												|MINUS -> machine := Mach(q,env, (t1-t2)::qi); false
												|MULT -> machine := Mach(q,env, (t1*t2)::qi); false
												|DIV -> machine := Mach(q,env, (t1/t2)::qi); false
												|MOD -> machine := Mach(q,env, (t1 mod t2)::qi); false

												|NEQUAL -> (if t1!=t2 then c0 := 1 else c0 := 0 );
														machine := Mach(q,env, (!c0)::qi); false
												|EQUAL  -> (if t1=t2  then c0 := 1 else c0 := 0 );
														machine := Mach(q,env, (!c0)::qi); false
												|INFEQ  -> (if t1<=t2 then c0 := 1 else c0 := 0 );
														machine := Mach(q,env, (!c0)::qi); false
												|INF    -> (if t1<t2  then c0 := 1 else c0 := 0 );
														machine := Mach(q,env, (!c0)::qi); false
												|SUPEQ  -> (if t1>=t2 then c0 := 1 else c0 := 0 );
														machine := Mach(q,env, (!c0)::qi); false
												|SUP    -> (if t1>t2  then c0 := 1 else c0 := 0 );
														machine := Mach(q,env, (!c0)::qi); false

												|AND -> machine := Mach(q,env, (t1*t2)::qi); false
												|OR  -> machine := Mach(q,env, (t1+t2)::qi); false
												|_ -> false
											  )
								|_ -> failwith "stack empty"
							   )
				)
		| _ -> failwith ""

	let init_and_compute prg =
		let mach = init prg in
		while not(step mach)
			do ()
		done

	let init_and_display prg =
		let mach = init prg in
			display mach

end
