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
  let env = Env.create () in
  let rec exec_aux = function
    |PrInt(a) ->  let x = exec_aux a in
                    print_int x; print_newline (); (x,e)
    |Let(x,a,p) -> let v = (exec_aux a) in
                    Env.add env x v;
                    exec_aux p
    |IfThenElse(b,p1,p2) -> let x = exec_aux b in
                              if (x==1) then (exec_aux p1) else (exec_aux p2)

    |Imp(p1,p2) -> exec_aux p1; exec_aux p2

    |Unop(op,a) -> let x = exec_aux a in
                  match op with
                    |Neg -> -x
                    |Not -> (1-x)
    |BinOp(a,op,b) -> let xa = exec_aux a and xb = exec_aux b in
                        match op with
                          |Add
                          |Minus
                          |
                          |
    |_ -> failwith "Execution error"
  in exec_aux prg
