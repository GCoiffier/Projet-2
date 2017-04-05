open Environnement
open Prog_type

let rec debug : programme -> unit = fun prg ->
    match prg with
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
                        debug b;
                        print_string ")"

    |Let(x,a,b) ->  print_string ("let "^x^" = (");
                    debug a;
                    print_string ") in (";
                    debug b;
                    print_string ")"

    |Imp(a,b) -> debug a;
                 print_string " ; ";
                 debug b

    |Function_def(x,a) -> print_string "(";
                          print_string "fun ";
                          debug x;
                          print_string " -> ";
                          debug a;
                          print_string ")"

    |Function_call(x,a) ->  debug x;
                            print_string " ";
                            debug a

    (* | _ -> failwith "Work in progress" *)
