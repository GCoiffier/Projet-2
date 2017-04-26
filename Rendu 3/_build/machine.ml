open Fouine_type

module type StackMachineSig = sig
	type machine

	val init : programme -> machine ref
	(* builds a stack machine out of a fouine program *)

	val display : machine ref -> unit
	(* prints the machine in the shell (ie the stack of instruction)*)

	val step : machine ref -> bool
	(* executes the instruction on top of the stack *)

	val init_and_compute : programme -> unit
	(* inits a machine and execute every instruction, then print out the result *)

	val init_and_display : programme -> unit
	(* inits a machine and prints its stack of instruction*)

end



module StackMachine : StackMachineSig = struct

	type instruction =
		INT of int
		| ADD | MINUS | MULT | DIV | MOD
		| UMINUS | PRINT

	type machine =
		Mach of instruction list * int * int list (*int est la cloture qui ne sera jamais utilise ici *)

	let rec build p_ l = match p_ with
		  Const(i) -> (INT(i))::l
	    | PrInt(p) -> (build p (PRINT::l))
	    | UnOp(Neg,p) -> (build p (UMINUS::l))
	    | BinOp(p1,Add,p2) -> (build p1 (build p2 (ADD::l)))
	    | BinOp(p1,Minus,p2) -> (build p1 (build p2 (MINUS::l)))
	    | BinOp(p1,Mult,p2) -> (build p1 (build p2 (MULT::l)))
	    | BinOp(p1,Div,p2) -> (build p1 (build p2 (DIV::l)))
	    | BinOp(p1,Mod,p2) -> (build p1 (build p2 (MOD::l)))
	    | _ -> failwith "not implemented in machine"

	let init p = ref (Mach( build p [], 0, []))

	let display machine =
		let rec print_instr_list = function
			|[] -> print_string ";;"
			|t::q ->
				( match t with
					  INT(i) -> print_int i
					| ADD -> print_string "ADD"
					| MINUS -> print_string "MINUS"
					| MULT -> print_string "MULT"
					| DIV -> print_string "DIV"
					| MOD -> print_string "MOD"
					| UMINUS -> print_string "UMINUS"
					| PRINT -> print_string "PRINT"
				);
				print_string "; " ;
				print_instr_list q
		in match (!machine) with Mach(l,_,_) -> print_instr_list l; print_newline ()

	let step machine =
		match !machine with
		  Mach([],_,t::[]) -> print_string "Result = "; print_int t; print_newline(); true
		| Mach(t::q,_,l) ->(
					match t with
					|INT(i) -> machine := Mach(q,0,i::l); false
					|UMINUS -> (match l with
								|[] -> failwith "expression not valid 1"
								|ti::qi -> machine := Mach(q,0, (-ti)::qi) ; false
							   )
					|PRINT ->  (match l with
								|[] -> failwith "expression not valid 2"
								|ti::qi -> print_int ti; print_newline(); machine := Mach(q,0,l) ; false
							   )

					|_ ->      (match l with
								|t2::t1::qi -> (match t with
												|ADD -> machine := Mach(q,0, (t1+t2)::qi); false
												|MINUS -> machine := Mach(q,0, (t1-t2)::qi); false
												|MULT -> machine := Mach(q,0, (t1*t2)::qi); false
												|DIV -> machine := Mach(q,0, (t1/t2)::qi); false
												|MOD -> machine := Mach(q,0, (t1 mod t2)::qi); false
												|_ -> false
											  )
								|_ -> failwith "expression not valid 3"
							   )
				)
		| _ -> failwith "expression not valid 4"

	let init_and_compute prg =
		let mach = init prg in
		while not(step mach)
			do ()
		done

	let init_and_display prg =
		let mach = init prg in
			display mach

end
