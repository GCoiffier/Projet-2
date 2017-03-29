open Data_structures

type arithexpr =
 Const of int
 |Var of variable
 |Plus of arithexpr * arithexpr
 |Neg of arithexpr
 |Minus of arithexpr * arithexpr
 |Mult of arithexpr * arithexpr
 |Div of arithexpr * arithexpr
 |Mod of arithexpr * arithexpr

module ArithExpr = struct

    let rec eval env = function
      Const(n) -> n
      |Var(x) -> (Environnement.find x e)
      |Plus(a,b) -> (eval a)+(eval b)
      |Neg(a) -> -(eval a)
      |Minus(a,b) -> -(eval a)-(eval b)
      |Mult(a,b) -> (eval a)*(eval b)
      |Div(a,b) -> (eval a)/(eval b)

    end
