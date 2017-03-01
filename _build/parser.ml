type token =
  | INT of (int)
  | AND
  | OR
  | NEG
  | XOR
  | IMP
  | EQ
  | MINUS
  | LPAREN
  | RPAREN
  | EOL

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
(* --- pr�ambule: ici du code Caml --- *)

open Formula   (* rappel: dans expr.ml: 
             type expr = Const of int | Add of expr*expr | Mull of expr*expr *)

# 23 "parser.ml"
let yytransl_const = [|
  258 (* AND *);
  259 (* OR *);
  260 (* NEG *);
  261 (* XOR *);
  262 (* IMP *);
  263 (* EQ *);
  264 (* MINUS *);
  265 (* LPAREN *);
  266 (* RPAREN *);
  267 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* INT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\002\000\003\000\003\000\003\000\002\000\003\000\
\003\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\000\000\000\000\000\000\011\000\000\000\
\007\000\003\000\000\000\000\000\000\000\000\000\000\000\000\000\
\001\000\004\000\005\000\000\000\000\000\000\000\000\000"

let yydgoto = "\002\000\
\007\000\008\000"

let yysindex = "\004\000\
\038\255\000\000\000\000\038\255\000\255\038\255\000\000\011\255\
\000\000\000\000\018\255\038\255\038\255\038\255\038\255\038\255\
\000\000\000\000\000\000\056\255\013\255\054\255\001\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\030\255\024\255\042\255\044\255"

let yygindex = "\000\000\
\000\000\252\255"

let yytablesize = 61
let yytable = "\009\000\
\010\000\011\000\012\000\013\000\001\000\014\000\015\000\019\000\
\020\000\021\000\022\000\023\000\012\000\013\000\012\000\014\000\
\015\000\016\000\000\000\012\000\013\000\017\000\014\000\015\000\
\016\000\000\000\008\000\018\000\008\000\008\000\008\000\000\000\
\006\000\008\000\008\000\006\000\006\000\000\000\003\000\006\000\
\006\000\004\000\000\000\000\000\000\000\005\000\006\000\009\000\
\009\000\000\000\010\000\009\000\009\000\010\000\010\000\012\000\
\013\000\012\000\014\000\000\000\014\000"

let yycheck = "\004\000\
\001\001\006\000\002\001\003\001\001\000\005\001\006\001\012\000\
\013\000\014\000\015\000\016\000\002\001\003\001\002\001\005\001\
\006\001\007\001\255\255\002\001\003\001\011\001\005\001\006\001\
\007\001\255\255\003\001\010\001\005\001\006\001\007\001\255\255\
\003\001\010\001\011\001\006\001\007\001\255\255\001\001\010\001\
\011\001\004\001\255\255\255\255\255\255\008\001\009\001\006\001\
\007\001\255\255\007\001\010\001\011\001\010\001\011\001\002\001\
\003\001\002\001\005\001\255\255\005\001"

let yynames_const = "\
  AND\000\
  OR\000\
  NEG\000\
  XOR\000\
  IMP\000\
  EQ\000\
  MINUS\000\
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
# 32 "parser.mly"
                            ( _1 )
# 115 "parser.ml"
               : Formula.formula))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 35 "parser.mly"
                          ( Var _1 )
# 122 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 36 "parser.mly"
                          ( NOT(Var _2) )
# 129 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 37 "parser.mly"
                          ( _2 )
# 136 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 38 "parser.mly"
                          ( AND(_1,_3) )
# 144 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "parser.mly"
                          ( OR(_1,_3) )
# 152 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 40 "parser.mly"
                          ( NOT(_2) )
# 159 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 41 "parser.mly"
                          ( XOR(_1,_3) )
# 167 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 42 "parser.mly"
                          ( IMPLIES(_1,_3) )
# 175 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 43 "parser.mly"
                          ( EQUIV(_1,_3) )
# 183 "parser.ml"
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