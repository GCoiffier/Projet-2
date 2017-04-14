type variable = string

(* opérateurs unaires *)
type unary_op = Not | Neg

(* opérateurs binaires *)
type binary_op = Equal | Neq | Infeq | Inf | Supeq | Sup
                 | And | Or | Add | Mult | Minus | Div | Mod

(* le type d'un programme fouine après parsing *)
type programme =
    Unit
    | Const of int
    | Var of variable
    | PrInt of programme
    | PrStr of variable
    | PrNL
    | UnOp of unary_op * programme
    | BinOp of programme * binary_op * programme
    | Let of programme  * programme * programme (* let x = A in B  : (x,A,B) *)
    | LetRec of programme * programme * programme
    | Function_def of programme * programme  (* fun x -> A  :  (x,A) *)
    | Function_call of programme * programme (* f A : (f,A) *)
    | IfThenElse of programme * programme * programme (* if x then A else B : (x,A,B) *)
    | TryWith of programme * programme * programme (* try A with E x -> B : (A,x,B) *)
    | Raise of programme
    | Imp of programme * programme (* A;B *)
    | Ref of programme (* ref A *)
    | Bang of programme  (* !x *)
    | Assign of programme * programme (* x := A *)
    | AMake of programme
    | Affect of programme * programme * programme (* t.(i) <- x : (t,i,x) *)
    | Access of programme * programme (* t.(i)  : (t,i) *)
