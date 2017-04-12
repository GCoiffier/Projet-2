open Prog_type

type instruction =
	INT of int

	| ADD
	| MINUS
	| MULT
	| DIV
	| MOD

	| UMINUS
	| PRINT

type machine =
	Mach of instruction list * int * int list (*int est la cloture qui ne sera jamais utilise ici *)

let rec built p_ l = match p_ with
	Unit -> failwith "not implement in machine"
	| Const(i) -> (INT(i))::l
    | Var(v) -> failwith "not implement in machine"
    | PrInt(p) -> (built p (PRINT::l))
    | PrStr(v) -> failwith "not implement in machine"
    | PrNL -> failwith "not implement in machine"
    | UnOp(Neg,p) -> (built p (UMINUS::l))
    | UnOp(_,p) -> failwith "not implement in machine"
    | BinOp(p1,Add,p2) -> (built p1 (built p2 (ADD::l)))
    | BinOp(p1,Minus,p2) -> (built p1 (built p2 (MINUS::l)))
    | BinOp(p1,Mult,p2) -> (built p1 (built p2 (MULT::l)))
    | BinOp(p1,Div,p2) -> (built p1 (built p2 (DIV::l)))
    | BinOp(p1,Mod,p2) -> (built p1 (built p2 (MOD::l)))
    | BinOp(p1,_,p2) -> failwith "not implement in machine"
    | Let(x,a,b) -> failwith "not implement in machine" (* let x = A in B  : (x,A,B) *)
    | LetRec(f,a,b) ->failwith "not implement in machine"
    | Function_def(x,a) -> failwith "not implement in machine" (* fun x -> A  :  (x,A) *)
    | Function_call(f,a) -> failwith "not implement in machine" (* f A : (f,A) *)
    | IfThenElse(x,a,b) -> failwith "not implement in machine" (* if x then A else B : (x,A,B) *)
    | TryWith(x,a,b) -> failwith "not implement in machine" (* try A with E x -> B : (x,A,B) *)
    | Raise(a) -> failwith "not implement in machine"
    | Imp(a,b) -> failwith "not implement in machine" (* A;B *)
    | Ref(a) -> failwith "not implement in machine" (* ref A *)
    | Bang(x) -> failwith "not implement in machine" (* !x *)
    | Assign(x,a) -> failwith "not implement in machine" (* x := A *)

let init p = ref (Mach( built p [], 0, []))

let step machine = let m = !machine in
	match m with
	| Mach([],_,t::[]) -> print_string "End of calcul : "; print_int t; print_newline(); true
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
	| _ -> failwith "expression not valid "
