open Environnement
open Fouine_type

let pstr = print_string (* abréviation *)

let rec debug : programme -> unit = fun prg ->
    (* affiche le programme parsé dans la console *)
    match prg with
    Unit -> print_string "()"

    | Const(n) -> print_int n

    | Var(x) -> pstr x

    | PrInt(a) -> pstr "prInt("; debug a ; pstr ")"

	| PrStr(s) -> pstr "prStr \""; pstr s; pstr "\""

	| PrNL -> pstr "PrNL"

    | IfThenElse(b,p1,p2) -> pstr "If (" ;
                            debug b ;
                            pstr ") Then (" ;
                            debug p1 ;
                            pstr ") Else (";
                            debug p2;
                            pstr ")"

    | UnOp(op,a) -> pstr (match op with Neg -> "-(" | Not -> "~(");
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

    | Let(x,p1,p2) ->  pstr "let ";
                        debug x;
                        pstr " = (";
                        debug p1;
                        pstr ") in (";
                        debug p2;
                        pstr ")"

    | LetRec(x,p1,p2) -> pstr "let rec ";
                        debug x;
                        pstr " = ";
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

    | TryWith(p1,x,p2) -> pstr "try ";
                            debug p1;
                            pstr " with E ";
                            debug x;
                            pstr " -> ";
                            debug p2

    | Raise(x) -> pstr "raise E ("; debug x; pstr ")"

    | Imp(p1,p2) -> debug p1; pstr " ; "; debug p2;

    | Ref(p) -> pstr "ref "; debug p

    | Bang(x) -> pstr "!"; debug x

    | Assign(x,p) -> pstr "(" ; debug x ; pstr " := "; debug p ; pstr ")"

    | AMake(x) -> pstr "aMake (" ; debug x; pstr ")"

    | Affect(t,i,x) -> debug t; pstr ".("; debug i; pstr ") <- " ; debug x

    | Access(t,i) -> debug t; pstr ".("; debug i; pstr ")"
