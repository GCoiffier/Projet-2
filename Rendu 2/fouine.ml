type variable = string
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
    (*|Function of variable * programme *)


let print_prg prg = print_newline ();;

let execute prg =
  let env = Hashtbl.create 10 in
  let rec exec_aux = function
    Const(n) -> n
    |Var(x) -> Hashtbl.find env x
    |PrInt(a) ->  let x = exec_aux a in
                    print_int x; print_newline (); x
    |Let(x,a,p) -> let v = (exec_aux a) in
                    Hashtbl.add env x v;
                    let u = exec_aux p in
                    Hashtbl.remove env x; u
    |IfThenElse(b,p1,p2) -> let x = exec_aux b in
                              if (x==1) then (exec_aux p1) else (exec_aux p2)

    |Imp(p1,p2) -> let _ = exec_aux p1 in exec_aux p2

    |UnOp(op,a) -> let x = exec_aux a in
                  (match op with
                    |Neg -> -x
                    |Not -> (1-x) )
    |BinOp(a,op,b) -> let xa = exec_aux a and xb = exec_aux b in
                        match op with
                          | Add -> xa+xb
                          | Minus -> xa - xb
                          | And -> xa*xb
                          | Or -> if ((xa+xb)>0) then 1 else 0
                          | Mult -> xa*xb
                          | Div -> xa/xb
                          | Mod -> xa mod xb
                          | Equal -> if (xa==xb) then 1 else 0
                          | Neq -> if (xa<>xb) then 1 else 0
                          | Infeq -> if (xa<=xb) then 1 else 0
                          | Inf -> if (xa<xb) then 1 else 0
                          | Supeq -> if (xa>=xb) then 1 else 0
                          | Sup -> if (xa>xb) then 1 else 0
  in exec_aux prg
