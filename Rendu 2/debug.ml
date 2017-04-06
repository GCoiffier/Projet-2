open Environnement
open Prog_type

let pstr = print_string (* abréviation *)

let rec debug : programme -> unit = fun prg ->
    match prg with
    Const(n) -> print_int n

    | Var(x) -> pstr x

    | PrInt(a) -> pstr "prInt("; debug a ; pstr ")"

    | IfThenElse(b,p1,p2) -> pstr "If (" ;
                            debug b ;
                            pstr ") Then (" ;
                            debug p1 ;
                            pstr ") Else (";
                            debug p2;
                            pstr ")"

    | UnOp(op,a) -> pstr (match op with Neg -> "-(" | Not -> "!(");
                   debug a;
                   pstr ")"

    | BinOp(a,op,b) -> pstr "(";
                        debug a;
                        pstr ( match op with
                            | Add -> "+"     | Minus -> "-"  | And -> "&&"
                            | Or -> "||"     | Mult -> "*"   | Div -> "/"
                            | Mod -> " mod " | Equal -> "="  | Neq -> "<>"
                            | Infeq -> "<="  | Inf -> "<"    | Supeq -> ">="
                            | Sup -> ">");
                        debug b;
                        pstr ")"

    | Let(x,p1,p2) ->  pstr ("let "^x^" = ");
                    debug p1;
                    pstr " in ";
                    debug p2


    | Function_def(x,a) -> pstr "(";
                          pstr "fun ";
                          debug x;
                          pstr " -> ";
                          debug a;
                          pstr ")"

    | Function_call(x,a) ->  debug x;
                            pstr " ";
                            debug a

    | Function_rec_def(_,_) -> failwith "Not implemented yet"

    | TryWith(p1,x,p2) -> pstr "try ";
                            debug p1;
                            pstr " with | ";
                            debug x;
                            pstr " -> ";
                            debug p2

    | Raise(x) -> pstr "raise E "; debug x

    | Imp(p1,p2) -> debug p1; pstr " ; "; debug p2;

    | Ref(p) -> pstr "ref "; debug p

    | Bang(x) -> pstr "!("; debug x; pstr ")"

    | Assign(x,p) -> debug x ; pstr " := "; debug p
