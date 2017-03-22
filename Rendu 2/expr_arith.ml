(* open Expr *)

type arithexpr =
 Const of int
 |Plus of arithexpr * arithexpr
 |Minus of arithexpr
 |Mult of arithexpr * arithexpr
 |Div of arithexpr * arithexpr

module ArithExpr = struct

    type t = arithexpr

    let eval t env = 0

    end
