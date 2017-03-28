type arithexpr =
 Const of int
 |Plus of arithexpr * arithexpr
 |Neg of arithexpr
 |Minus of arithexpr * arithexpr
 |Mult of arithexpr * arithexpr
 |Div of arithexpr * arithexpr

module ArithExpr = struct

    let rec eval = function
      Const(n) -> n
      |Plus(a,b) -> (eval a)+(eval b)
      |Neg(a) -> -(eval a)
      |Minus(a,b) -> -(eval a)-(eval b)
      |Mult(a,b) -> (eval a)*(eval b)
      |Div(a,b) -> (eval a)/(eval b)

    end
