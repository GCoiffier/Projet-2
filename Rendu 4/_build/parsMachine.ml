type token =
  | INT of (int)
  | LET of (string)
  | ACCESS of (string)
  | ENDLET
  | ADD
  | MINUS
  | MULT
  | DIV
  | MOD
  | UMINUS
  | PRINT
  | AND
  | OR
  | EQUAL
  | NEQUAL
  | SUP
  | SUPEQ
  | INFEQ
  | INF
  | IF
  | ELSE
  | IFEND
  | EOL

open Parsing;;
let _ = parse_error;;
# 2 "parsMachine.mly"

open Machine

# 33 "parsMachine.ml"
let yytransl_const = [|
  260 (* ENDLET *);
  261 (* ADD *);
  262 (* MINUS *);
  263 (* MULT *);
  264 (* DIV *);
  265 (* MOD *);
  266 (* UMINUS *);
  267 (* PRINT *);
  268 (* AND *);
  269 (* OR *);
  270 (* EQUAL *);
  271 (* NEQUAL *);
  272 (* SUP *);
  273 (* SUPEQ *);
  274 (* INFEQ *);
  275 (* INF *);
  276 (* IF *);
  277 (* ELSE *);
  278 (* IFEND *);
  279 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* LET *);
  259 (* ACCESS *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\000\000"

let yylen = "\002\000\
\002\000\001\000\002\000\005\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\005\000\021\000\022\000\023\000\006\000\007\000\
\008\000\009\000\010\000\011\000\012\000\013\000\014\000\015\000\
\016\000\020\000\019\000\017\000\018\000\000\000\024\000\000\000\
\000\000\000\000\001\000\003\000\000\000\000\000\004\000"

let yydgoto = "\002\000\
\023\000\024\000\025\000"

let yysindex = "\020\000\
\255\254\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\255\254\000\000\005\255\
\255\254\001\255\000\000\000\000\255\254\007\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\003\255\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\254\255\000\000"

let yytablesize = 29
let yytable = "\003\000\
\004\000\005\000\006\000\007\000\008\000\009\000\010\000\011\000\
\012\000\013\000\014\000\015\000\016\000\017\000\018\000\019\000\
\020\000\021\000\022\000\026\000\001\000\029\000\028\000\002\000\
\002\000\002\000\030\000\027\000\031\000"

let yycheck = "\001\001\
\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\018\001\019\001\020\001\022\000\001\000\021\001\025\000\021\001\
\022\001\023\001\029\000\023\001\022\001"

let yynames_const = "\
  ENDLET\000\
  ADD\000\
  MINUS\000\
  MULT\000\
  DIV\000\
  MOD\000\
  UMINUS\000\
  PRINT\000\
  AND\000\
  OR\000\
  EQUAL\000\
  NEQUAL\000\
  SUP\000\
  SUPEQ\000\
  INFEQ\000\
  INF\000\
  IF\000\
  ELSE\000\
  IFEND\000\
  EOL\000\
  "

let yynames_block = "\
  INT\000\
  LET\000\
  ACCESS\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instrl) in
    Obj.repr(
# 25 "parsMachine.mly"
                                                    ( _1 )
# 146 "parsMachine.ml"
               : Machine.instruction list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 28 "parsMachine.mly"
                 ( [_1] )
# 153 "parsMachine.ml"
               : 'instrl))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instrl) in
    Obj.repr(
# 29 "parsMachine.mly"
                       ( _1::_2 )
# 161 "parsMachine.ml"
               : 'instrl))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'instrl) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'instrl) in
    Obj.repr(
# 33 "parsMachine.mly"
                                     ( IF(_2,_4) )
# 169 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 34 "parsMachine.mly"
                   ( INT(_1) )
# 176 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 36 "parsMachine.mly"
                   ( ADD )
# 182 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 37 "parsMachine.mly"
                   ( MINUS )
# 188 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 38 "parsMachine.mly"
                  ( MULT )
# 194 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "parsMachine.mly"
                 ( DIV )
# 200 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 40 "parsMachine.mly"
                 ( MOD )
# 206 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 41 "parsMachine.mly"
                   ( UMINUS )
# 212 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 42 "parsMachine.mly"
                   ( PRINT )
# 218 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 44 "parsMachine.mly"
                 ( AND )
# 224 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 45 "parsMachine.mly"
                ( OR )
# 230 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 46 "parsMachine.mly"
                   ( EQUAL )
# 236 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 47 "parsMachine.mly"
                   ( NEQUAL )
# 242 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 48 "parsMachine.mly"
                   ( INFEQ )
# 248 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 49 "parsMachine.mly"
                 ( INF )
# 254 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 50 "parsMachine.mly"
                   ( SUPEQ )
# 260 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 51 "parsMachine.mly"
                 ( SUP )
# 266 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 53 "parsMachine.mly"
                 ( LET(_1) )
# 273 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 54 "parsMachine.mly"
                   ( ACCESS(_1) )
# 280 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 55 "parsMachine.mly"
                   ( ENDLET )
# 286 "parsMachine.ml"
               : 'instr))
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : Machine.instruction list)
