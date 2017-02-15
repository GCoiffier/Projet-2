type token =
  | INT of (int)
  | AND
  | OR
  | NEG
  | XOR
  | LPAREN
  | RPAREN
  | EOL

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
(* --- préambule: ici du code Caml --- *)

open Formula   (* rappel: dans expr.ml: 
             type expr = Const of int | Add of expr*expr | Mull of expr*expr *)

# 20 "parser.ml"
let yytransl_const = [|
  258 (* AND *);
  259 (* OR *);
  260 (* NEG *);
  261 (* XOR *);
  262 (* LPAREN *);
  263 (* RPAREN *);
  264 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* INT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\003\000\003\000\003\000\002\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\000\000\000\000\008\000\000\000\000\000\
\000\000\000\000\000\000\000\000\001\000\003\000\000\000\000\000\
\000\000"

let yydgoto = "\002\000\
\006\000\007\000"

let yysindex = "\003\000\
\023\255\000\000\000\000\023\255\023\255\000\000\007\255\000\255\
\018\255\023\255\023\255\023\255\000\000\000\000\006\255\029\255\
\000\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\009\255\
\000\000\000\000\000\000\000\000\000\000\000\000\011\255\025\255\
\028\255"

let yygindex = "\000\000\
\000\000\252\255"

let yytablesize = 36
let yytable = "\008\000\
\009\000\010\000\011\000\001\000\012\000\015\000\016\000\017\000\
\010\000\011\000\012\000\012\000\004\000\004\000\013\000\006\000\
\006\000\004\000\004\000\010\000\011\000\000\000\012\000\003\000\
\014\000\000\000\004\000\005\000\005\000\000\000\010\000\005\000\
\005\000\012\000\007\000\007\000"

let yycheck = "\004\000\
\005\000\002\001\003\001\001\000\005\001\010\000\011\000\012\000\
\002\001\003\001\005\001\005\001\002\001\003\001\008\001\007\001\
\008\001\007\001\008\001\002\001\003\001\255\255\005\001\001\001\
\007\001\255\255\004\001\003\001\006\001\255\255\002\001\007\001\
\008\001\005\001\007\001\008\001"

let yynames_const = "\
  AND\000\
  OR\000\
  NEG\000\
  XOR\000\
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
# 28 "parser.mly"
                            ( _1 )
# 98 "parser.ml"
               : Formula.formula))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 31 "parser.mly"
                            ( Var _1 )
# 105 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 32 "parser.mly"
                            ( _2 )
# 112 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 33 "parser.mly"
                          ( AND(_1,_3) )
# 120 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 34 "parser.mly"
                          ( OR(_1,_3) )
# 128 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 35 "parser.mly"
                          ( NOT(_2) )
# 135 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 36 "parser.mly"
                          ( XOR(_1,_3) )
# 143 "parser.ml"
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
