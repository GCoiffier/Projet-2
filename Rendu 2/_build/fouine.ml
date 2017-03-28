open Expr_bool
open Expr_arith
open Data_structures

type programme =
     Const of int
    |Var of variable
    |Let of variable * programme * programme (* let x = A in B -> (x,A,B) *)
    |IfThenElse of boolexpr * programme * programme


let print_prg prg = print_newline ();;

let execute prg =
  let rec exec_aux e = function
    |Const(k) -> k
    |Var(x) -> (Environnement.find x e)
    |Let(x,p1,p2) -> let v = exec_aux e p1 in
                        exec_aux (Environnement.add x v e) p2
    |IfThenElse(b,e1,e2) -> if (Boolexpr.eval b) then (exec_aux e e1) else (exec_aux e e2)
  in exec_aux (Environnement.empty) prg
