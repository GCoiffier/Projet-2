open Environnement
open Prog_type

exception Error of int

type ret = Env.elt (* Le type de retour de l'interprétation *)

let return : ret -> int = function
    Env.Int(n) -> n
    | _ -> failwith "Execution Error"

let execute : programme -> int = fun prg ->
  let rec exec_aux env = function
    Const(n) -> Env.Int(n)

    |Var(x) as v -> Env.find env v

    |PrInt(a) -> let r = (exec_aux env a) in
                  ( match r with
                     Env.Int(x) -> print_int x; print_newline ()
                     |_ -> failwith "Execution Error in prInt"
                  ) ; r

    |Let(x,val_x,p) ->  Env.add env (Var(x)) (exec_aux env val_x);
                        let ret = (exec_aux env p) in
                        Env.remove env (Var(x)); ret

    |IfThenElse(b,p1,p2) -> let x = return (exec_aux env b) in
                              if (x==1) then (exec_aux env p1)
                                        else (exec_aux env p2)

    |UnOp(op,a) ->  let x = return (exec_aux env a) in
                    ( match op with
                         Neg -> Env.Int(-x)
                       | Not -> Env.Int(1-x)
                    )

    |BinOp(a,op,b) -> let xa = return (exec_aux env a) and
                          xb = return (exec_aux env b) in
                      let c1 = Env.Int(1) and c0 = Env.Int(0) in
                       ( match op with
                          | Add -> Env.Int(xa+xb)
                          | Minus -> Env.Int(xa - xb)
                          | And -> Env.Int(xa*xb)
                          | Or -> if ((xa+xb)>0) then c1 else c0
                          | Mult -> Env.Int(xa*xb)
                          | Div -> Env.Int(xa/xb)
                          | Mod -> Env.Int(xa mod xb)
                          | Equal -> if (xa==xb) then c1 else c0
                          | Neq -> if (xa<>xb) then c1 else c0
                          | Infeq -> if (xa<=xb) then c1 else c0
                          | Inf -> if (xa<xb) then c1 else c0
                          | Supeq -> if (xa>=xb) then c1 else c0
                          | Sup -> if (xa>xb) then c1 else c0 )

    | Function_def(_,_) as f -> Env.Cloture(f, Env.copy env)

    | Function_call(f,arg) -> let v = (exec_aux env f) in
                                (match v with
                                | Env.Cloture(Function_def(x,expr), clt ) ->
                                    let _ = Env.add clt x (exec_aux env arg) in
                                    exec_aux clt expr
                                | _ -> failwith "Error in function call")

    | Function_rec_def(_,_) -> failwith "Not implemented yet"

    | TryWith(e1,e2) -> failwith "Not implemented yet"
                    (*let env2 = Env.copy env in
                       try
                        (exec_aux env e1)
                       with | Error(u) -> (exec_aux env2 e2) *)

    | Raise(x) -> failwith "Not implemented yet"
                (*let u = return (exec_aux env x) in
                    raise (Error u) *)

    | Imp(p1,p2) -> let _ = exec_aux env p1 in exec_aux env p2

    | Ref(x,p) -> failwith "Not implemented yet"

    | Bang(x) -> failwith "Not implemented yet"

    | Assign(x,p) -> failwith "Not implemented yet"

  in return (exec_aux (Env.create 10) prg)
