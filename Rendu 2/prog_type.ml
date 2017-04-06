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
    |Function_def of programme * programme
    |Function_call of programme * programme
    |Function_rec_def of programme * programme
    |TryWith of programme * programme
    |Raise of programme
    |Imp of programme * programme (* A;B *)
    |Ref of variable * programme
    |Bang of variable
    |Assign of variable * programme
