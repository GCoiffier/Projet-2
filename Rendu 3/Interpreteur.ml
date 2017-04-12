open Environnement
open Prog_type

type ret = Env.elt (* Le type de retour de l'interprétation *)

exception E of Env.elt (* Ce type retour peut être une exception *)

let return : ret -> int = function
      Env.Int(n) -> n
    | Env.Ref(_) -> failwith "Execution Error: expected integer, got reference"
    | Env.Cloture(_,_) -> failwith "Execution Error: expected integer, got function"

let execute : programme -> int = fun prg ->

    let rec exec_aux env stack  = function

    Unit -> Env.Int(0)

    | Const(n) -> Env.Int(n)

    | Var(x) as v -> Env.find env v

    | PrInt(p) -> let ret = (exec_aux env stack p) in
                  ( match ret with
                     Env.Int(x) -> print_int x; print_string " "
                     |_ -> failwith "Execution Error in prInt"
                  ) ; ret

	| PrStr(s) -> print_string s ; Env.Int(0)

	| PrNL -> print_newline(); Env.Int(0)

    | Let(x,val_x,p) ->  Env.add env x (exec_aux env stack val_x);
                        let ret = (exec_aux env stack p) in
                        Env.remove env x; ret

    | LetRec(f,expr_f,p) ->  let copy = Env.copy env in
                            let clt = Env.Cloture(expr_f, copy) in
                            Env.add copy f clt; (* Comme la fonction s'appelle elle-même, la cloture se contient elle même*)
                            Env.add env f clt;
                            let ret = (exec_aux env stack  p) in
                            Env.remove env f; ret

    | IfThenElse(b,p1,p2) -> let x = return (exec_aux env stack b) in
                              if (x==1) then (exec_aux env stack p1)
                                        else (exec_aux env stack p2)

    | UnOp(op,a) ->  let x = return (exec_aux env stack a) in
                    ( match op with
                         Neg -> Env.Int(-x)
                       | Not -> Env.Int(1-x)
                    )

    | BinOp(a,op,b) -> let xa = return (exec_aux env stack a) and
                          xb = return (exec_aux env stack b) in
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
                          | Sup -> if (xa>xb) then c1 else c0
                       )

    | Function_def(_,_) as f -> Env.Cloture(f, Env.copy env)

    | Function_call(f,arg) -> let v = (exec_aux env stack  f) in
                                (match v with
                                | Env.Cloture(Function_def(x,expr), clt ) ->
                                    Env.add clt x (exec_aux env stack  arg);
                                    let ret = exec_aux clt stack expr in
                                    Env.remove clt x; ret
                                | _ -> failwith "Error in function call"
                                )

    | TryWith(p1,x,p2) -> Stack.push (Env.copy env, x , p2) stack;
                          exec_aux env stack p1

    | Raise(expr) -> (try
                    let old_env,x,p = Stack.pop stack in (* la pile peut être vide : raise Stack.Empty *)
                    let ret = (exec_aux env stack expr) in
                     Env.add old_env x ret;
                     exec_aux old_env stack p
                  with | Stack.Empty -> failwith "Error : exception not caught"
                  )
                  
    | Imp(p1,p2) -> let _ = exec_aux env stack  p1 in exec_aux env stack  p2

    | Ref(x) -> let v = return (exec_aux env stack  x) in Env.Ref(v)

    | Bang(x) -> let u = (Env.find env x) in
                    (match u with
                        Env.Ref(a) -> Env.Int(a)
                        | _ -> failwith "Error : Not a reference"
                    )

    | Assign(x,p) -> let u = return (exec_aux env stack p) in
                        Env.remove env x;
                        Env.add env x (Env.Ref(u));
                        Env.Int(u)

    in return (exec_aux (Env.create 10) (Stack.create ()) prg)
