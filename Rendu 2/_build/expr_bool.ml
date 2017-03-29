open Expr_arith
open Data_structures

type compr= Equal | Neq | Infeq | Inf | Supeq | Sup

type boolexpr =
  Const of bool
  |Not of boolexpr
  |And of boolexpr * boolexpr
  |Or of boolexpr * boolexpr
  |Comp of arithexpr * compr * arithexpr

module Boolexpr = struct

    let rec eval env = function
      Const(x) -> x
      |Not(e) -> not (eval env e)
      |And(e1,e2) -> (eval env e1) && (eval env e2)
      |Or(e1,e2) -> (eval env e1) || (eval env e2)
      |Comp(a,c,b) -> let va = (ArithExpr.eval env a) and
                          vb = (ArithExpr.eval env b) in
                      match c with
                      Equal -> (va=vb)
                      |Neq -> (va<>vb)
                      |Infeq -> (va<=vb)
                      |Inf -> (va<vb)
                      |Supeq -> (va>=vb)
                      |Sup -> (va>vb)

end
