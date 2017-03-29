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
      |Var(x) -> (Environnement.find x env)
      |Plus(a,b) -> (eval env a)+(eval env b)
      |Neg(a) -> -(eval env a)
      |Minus(a,b) -> (eval env a)-(eval env b)
      |Mult(a,b) -> (eval env a)*(eval env b)
      |Div(a,b) -> (eval env a)/(eval env b)
      |Mod(a,b) -> (eval env a) mod (eval env b)

    let rec print_expr = function
      |Const(n) -> print_int n
      |Var(x) -> print_string x
      |Neg(a) -> print_string "-"; print_expr a
      |Plus(a,b) -> print_expr a ; print_string " + " ; print_expr b
      |Minus(a,b) -> print_expr a ; print_string " - " ; print_expr b
      |Mult(a,b) -> print_expr a ; print_string " * " ; print_expr b
      |Div(a,b) -> print_expr a ; print_string " / " ; print_expr b
      |Mod(a,b) -> print_expr a ; print_string " mod " ; print_expr b

    end
