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
    |Imp of programme * programme (* A;B *)
    |Function of variable * programme * programme


let debug prg = print_string "Debug mode";;

let execute prg =
  let env = Hashtbl.create 10 in
  let rec exec_aux = function
    Const(n) -> Const(n)

    |Var(x) as v -> Hashtbl.find env v

    |PrInt(a) -> let r = (exec_aux a) in
                  ( match r with
                     Const(x) -> print_int x; print_newline ()
                     |_ -> failwith "Execution Error in prInt"
                  ) ; r

    |Let(x,a,p) -> let v = (exec_aux a) in
                    Hashtbl.add env (Var(x)) v;
                    let u = exec_aux p in
                    Hashtbl.remove env (Var(x)); u

    |IfThenElse(b,p1,p2) -> ( match (exec_aux b) with
                              Const(x) -> if (x==1) then (exec_aux p1) else (exec_aux p2)
                              | _ -> failwith "Execution Error in IfThenElse"
                            )

    |Imp(p1,p2) -> let _ = exec_aux p1 in exec_aux p2

    |UnOp(op,a) ->  ( match (exec_aux a) with
                        |Const(x) -> (match op with
                                         Neg -> Const(-x)
                                        |Not -> Const(1-x) )
                        | _ -> failwith "Execution Error in UnOp")

    |BinOp(a,op,b) -> let ra = exec_aux a and rb = exec_aux b in
                        ( match (ra,rb) with
                        Const(xa),Const(xb) ->
                          let c1 = Const(1) and c0 = Const(0) in
                          ( match op with
                                  | Add -> Const(xa+xb)
                                  | Minus -> Const(xa - xb)
                                  | And -> Const(xa*xb)
                                  | Or -> if ((xa+xb)>0) then c1 else c0
                                  | Mult -> Const(xa*xb)
                                  | Div -> Const(xa/xb)
                                  | Mod -> Const(xa mod xb)
                                  | Equal -> if (xa==xb) then c1 else c0
                                  | Neq -> if (xa<>xb) then c1 else c0
                                  | Infeq -> if (xa<=xb) then c1 else c0
                                  | Inf -> if (xa<xb) then c1 else c0
                                  | Supeq -> if (xa>=xb) then c1 else c0
                                  | Sup -> if (xa>xb) then c1 else c0
                          )
                        | _ -> failwith "Execution Error in BinOp"
                        )
    |_ -> failwith "Not implemented yet"

  in match (exec_aux prg) with
    Const(result) -> result
    |_ -> failwith "Execution Error"
