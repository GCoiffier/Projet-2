open Data_structures

type unary_op = Not | Neg
type binary_op = Equal | Neq | Infeq | Inf | Supeq | Sup
                 | And | Or | Add | Mult | Minus | Div | Mod

type programme =
    Const of int
    |Var of variable
    |UnOp of unary_op * programme
    |BinOp of programme * binary_op * programme
    |Let of variable * programme * programme (* let x = A in B -> (x,A,B) *)
    |IfThenElse of programme * programme * programme (* if x then A else B -> (x,A,B) *)
    |PrInt of programme
    |Imp of programme * programme
    |Function of variable * programme


let print_prg prg = print_newline ();;

let execute prg =
  let rec exec_aux e = function

    
    |PrInt(a) -> let x = (ArithExpr.eval e a) in
                    print_int x; print_newline (); (x,e)
    |Let(x,a,p) -> let v = (ArithExpr.eval e a) in
                        exec_aux (Environnement.add x v e) p
    |IfThenElse(b,p1,p2) -> if (Boolexpr.eval e b) then (exec_aux e p1) else (exec_aux e p2)
    |Imp(p1,p2) -> let ep = snd (exec_aux e p1) in  (exec_aux ep p2)
    |_ -> failwith "Execution error"
  in fst (exec_aux (Environnement.empty) prg)
