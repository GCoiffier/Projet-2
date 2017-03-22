open Expr_bool
open Expr_arith

type variable = string

type programme =
     Const of int
    |Var of variable
    |Let of variable * programme * programme (* let x = A in B -> (x,A,B) *)
    |IfThenElse of boolexpr * programme * programme
