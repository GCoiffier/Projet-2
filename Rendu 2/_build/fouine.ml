open Expr_bool
open Expr_arith
open Data_structures

type programme =
    Arith of arithexpr
    |Var of variable
    |Let of variable * arithexpr (* let x = A in B -> (x,A);B *)
    |IfThenElse of boolexpr * programme * programme
    |PrInt of arithexpr
    |Imp of programme * programme
    |Function of variable * programme


let print_prg prg = print_newline ();;

let execute prg =
  let rec exec_aux e = function
    Arith(a) -> (ArithExpr.eval e a) , e
    |PrInt(a) -> let x = (ArithExpr.eval e a) in
                    print_int x; print_newline (); (x,e)
    |Var(x) -> (Environnement.find x e) , e
    |Let(x,p1) -> let v,ep = (exec_aux e p1) in
                        exec_aux (Environnement.add x v ep) p1
    |IfThenElse(b,p1,p2) -> if (Boolexpr.eval b) then (exec_aux e p1) else (exec_aux e p2)
    |Imp(p1,p2) -> let ep = snd (exec_aux e p1) in  (exec_aux ep p2)
    |_ -> failwith "Execution error"
  in fst (exec_aux (Environnement.empty) prg)
