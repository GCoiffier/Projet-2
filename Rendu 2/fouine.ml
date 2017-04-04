open Environnement
open Prog_type

let rec debug = function
    Const(n) -> print_int n
    |Var(x) -> print_string x
    |PrInt(a) -> print_string "prInt("; debug a ; print_string ")"
    |IfThenElse(b,p1,p2) -> print_string "If (" ;
                            debug b ;
                            print_string ") Then (" ;
                            debug p1 ;
                            print_string ") Else (";
                            debug p2;
                            print_string ")"
    |UnOp(op,a) -> print_string (match op with Neg -> "-(" | Not -> "!(");
                   debug a;
                   print_string ")"
    |BinOp(a,op,b) -> print_string "(";
                        debug a;
                        print_string ( match op with
                            | Add -> "+"     | Minus -> "-"  | And -> "&&"
                            | Or -> "||"     | Mult -> "*"   | Div -> "/"
                            | Mod -> " mod " | Equal -> "="  | Neq -> "<>"
                            | Infeq -> "<="  | Inf -> "<"    | Supeq -> ">="
                            | Sup -> ">");
                        debug b
    |Let(x,a,b) ->  print_string ("let "^x^" = (");
                    debug a;
                    print_string ") in (";
                    debug b;
                    print_string ")"
    |Imp(a,b) -> debug a;
                 print_string " ; ";
                 debug b
    |Function_def(x,a) -> print_string ("fun "^x^" -> ");
                        debug a
    | _ -> failwith "Work in progress"


let return = function
    |Const(n) -> n
    | _ -> failwith "Execution Error"

let execute prg =
  let env = Env.create 10 in
  let rec exec_aux = function
    Const(n) -> Const(n)

    |Var(x) as v -> Env.find env v

    |PrInt(a) -> let r = (exec_aux a) in
                  ( match r with
                     Const(x) -> print_int x; print_newline ()
                     |_ -> failwith "Execution Error in prInt"
                  ) ; r

    |Let(x,val_x,p) -> let v = (exec_aux val_x) in
                    Env.add env (Var(x)) v;
                    let u = (exec_aux p) in
                    Env.remove env (Var(x));
                    u

    |IfThenElse(b,p1,p2) -> let x = return (exec_aux b) in
                              if (x==1) then (exec_aux p1) else (exec_aux p2)

    |Imp(p1,p2) -> let _ = exec_aux p1 in exec_aux p2

    |UnOp(op,a) ->  let x = return (exec_aux a) in
                        (   match op with
                                Neg -> Const(-x)
                               |Not -> Const(1-x)
                        )

    |BinOp(a,op,b) -> let xa = return (exec_aux a) and
                          xb = return (exec_aux b) in
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
                          | Sup -> if (xa>xb) then c1 else c0 )

    |Function_def(x,a) as f -> failwith "not implemented yet"


    |Function_call(f,x) -> failwith "not implemented yet"

  in return (exec_aux prg)
