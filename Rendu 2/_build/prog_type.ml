type variable = string

type unary_op = Not | Neg

type binary_op = Equal | Neq | Infeq | Inf | Supeq | Sup
                 | And | Or | Add | Mult | Minus | Div | Mod

type programme =
    Const of int
    |Var of variable
    |PrInt of programme
    |UnOp of unary_op * programme
    |BinOp of programme * binary_op * programme
    |Let of variable * programme * programme (* let x = A in B -> (x,A,B) *)
    |IfThenElse of programme * programme * programme (* if x then A else B -> (x,A,B) *)
    |Imp of programme * programme (* A;B *)
    |Function_def of variable * programme
    |Function_call of programme * programme
