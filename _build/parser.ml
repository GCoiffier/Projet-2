type token =
  | INT of (int)
  | AND
  | OR
  | NEG
  | XOR
  | IMP
  | EQ
  | MINUS
  | FIN
  | LPAREN
  | RPAREN
  | EOL

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
(* --- préambule: ici du code Caml --- *)

open Formula   (* rappel: dans expr.ml: 
             type expr = Const of int | Add of expr*expr | Mull of expr*expr *)

# 24 "parser.ml"
let yytransl_const = [|
  258 (* AND *);
  259 (* OR *);
  260 (* NEG *);
  261 (* XOR *);
  262 (* IMP *);
  263 (* EQ *);
  264 (* MINUS *);
  265 (* FIN *);
  266 (* LPAREN *);
  267 (* RPAREN *);
  268 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* INT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\000\000"

let yylen = "\002\000\
\002\000\002\000\001\000\002\000\003\000\003\000\003\000\002\000\
\003\000\003\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\003\000\000\000\000\000\000\000\012\000\000\000\
\008\000\004\000\000\000\000\000\000\000\000\000\000\000\000\000\
\002\000\001\000\005\000\006\000\000\000\000\000\000\000\000\000"

let yydgoto = "\002\000\
\007\000\008\000"

let yysindex = "\014\000\
\042\255\000\000\000\000\042\255\018\255\042\255\000\000\011\255\
\000\000\000\000\019\255\042\255\042\255\042\255\042\255\042\255\
\000\000\000\000\000\000\000\000\002\255\025\255\046\255\058\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\033\255\026\255\047\255\250\254"

let yygindex = "\000\000\
\000\000\252\255"

let yytablesize = 64
let yytable = "\009\000\
\011\000\011\000\011\000\012\000\011\000\011\000\014\000\020\000\
\021\000\022\000\023\000\024\000\012\000\013\000\001\000\014\000\
\015\000\016\000\010\000\017\000\012\000\013\000\018\000\014\000\
\015\000\016\000\012\000\017\000\009\000\019\000\009\000\009\000\
\009\000\000\000\009\000\007\000\009\000\009\000\007\000\007\000\
\000\000\007\000\003\000\007\000\007\000\004\000\000\000\012\000\
\013\000\005\000\014\000\006\000\010\000\010\000\000\000\010\000\
\000\000\010\000\010\000\012\000\013\000\000\000\014\000\015\000"

let yycheck = "\004\000\
\007\001\006\000\009\001\002\001\011\001\012\001\005\001\012\000\
\013\000\014\000\015\000\016\000\002\001\003\001\001\000\005\001\
\006\001\007\001\001\001\009\001\002\001\003\001\012\001\005\001\
\006\001\007\001\002\001\009\001\003\001\011\001\005\001\006\001\
\007\001\255\255\009\001\003\001\011\001\012\001\006\001\007\001\
\255\255\009\001\001\001\011\001\012\001\004\001\255\255\002\001\
\003\001\008\001\005\001\010\001\006\001\007\001\255\255\009\001\
\255\255\011\001\012\001\002\001\003\001\255\255\005\001\006\001"

let yynames_const = "\
  AND\000\
  OR\000\
  NEG\000\
  XOR\000\
  IMP\000\
  EQ\000\
  MINUS\000\
  FIN\000\
  LPAREN\000\
  RPAREN\000\
  EOL\000\
  "

let yynames_block = "\
  INT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 33 "parser.mly"
                            ( _1 )
# 118 "parser.ml"
               : Formula.formula))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 36 "parser.mly"
                ( _1 )
# 125 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 37 "parser.mly"
                          ( Var _1 )
# 132 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 38 "parser.mly"
                          ( NOT(Var _2) )
# 139 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 39 "parser.mly"
                          ( _2 )
# 146 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 40 "parser.mly"
                          ( AND(_1,_3) )
# 154 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 41 "parser.mly"
                          ( OR(_1,_3) )
# 162 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 42 "parser.mly"
                          ( NOT(_2) )
# 169 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 43 "parser.mly"
                          ( XOR(_1,_3) )
# 177 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 44 "parser.mly"
                          ( IMPLIES(_1,_3) )
# 185 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 45 "parser.mly"
                          ( EQUIV(_1,_3) )
# 193 "parser.ml"
               : 'expr))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Formula.formula)
