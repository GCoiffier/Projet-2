open Expr

type compr= Equal | Neq | Infeq | Inf | Supeq | Sup

type boolexpr =
  Const of bool
  |Not of boolexpr
  |And of boolexpr * boolexpr
  |Or of boolexpr * boolexpr
  |Comp of int * compr * int

module Boolexpr : Expr = struct

    type t = boolexpr
    type content = bool
    
    let rec eval = function
      Const(x) -> x
      |Not(e) -> not (eval e)
      |And(e1,e2) -> (eval e1) && (eval e2)
      |Or(e1,e2) -> (eval e1) || (eval e2)
      |Comp(a,c,b) -> match c with
                      Equal -> (a=b)
                      |Neq -> (a<>b)
                      |Infeq -> (a<=b)
                      |Inf -> (a<b)
                      |Supeq -> (a>=b)
                      |Sup -> (a>b)

end
