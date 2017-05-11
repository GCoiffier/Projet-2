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
  | POP
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
  | LETREC of (string)
  | FUNCT
  | RETURN
  | CALL

open Parsing;;
let _ = parse_error;;
# 2 "parsMachine.mly"

open Machine

# 38 "parsMachine.ml"
let yytransl_const = [|
  260 (* ENDLET *);
  261 (* ADD *);
  262 (* MINUS *);
  263 (* MULT *);
  264 (* DIV *);
  265 (* MOD *);
  266 (* UMINUS *);
  267 (* PRINT *);
  268 (* POP *);
  269 (* AND *);
  270 (* OR *);
  271 (* EQUAL *);
  272 (* NEQUAL *);
  273 (* SUP *);
  274 (* SUPEQ *);
  275 (* INFEQ *);
  276 (* INF *);
  277 (* IF *);
  278 (* ELSE *);
  279 (* IFEND *);
  280 (* EOL *);
  282 (* FUNCT *);
  283 (* RETURN *);
  284 (* CALL *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* LET *);
  259 (* ACCESS *);
  281 (* LETREC *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\000\000"

let yylen = "\002\000\
\002\000\001\000\002\000\005\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\003\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\005\000\022\000\023\000\024\000\006\000\007\000\
\008\000\009\000\010\000\011\000\012\000\013\000\014\000\015\000\
\016\000\017\000\021\000\020\000\018\000\019\000\000\000\027\000\
\000\000\026\000\028\000\000\000\000\000\000\000\000\000\001\000\
\003\000\000\000\025\000\000\000\004\000"

let yydgoto = "\002\000\
\027\000\028\000\029\000"

let yysindex = "\020\000\
\255\254\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\255\254\000\000\
\255\254\000\000\000\000\254\254\255\254\001\255\006\255\000\000\
\000\000\255\254\000\000\012\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\007\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\003\000\000\000"

let yytablesize = 37
let yytable = "\003\000\
\004\000\005\000\006\000\007\000\008\000\009\000\010\000\011\000\
\012\000\013\000\014\000\015\000\016\000\017\000\018\000\019\000\
\020\000\021\000\022\000\023\000\001\000\032\000\034\000\024\000\
\025\000\030\000\026\000\031\000\002\000\002\000\002\000\033\000\
\035\000\002\000\037\000\000\000\036\000"

let yycheck = "\001\001\
\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\018\001\019\001\020\001\021\001\001\000\024\001\022\001\025\001\
\026\001\023\000\028\001\025\000\022\001\023\001\024\001\029\000\
\027\001\027\001\023\001\255\255\034\000"

let yynames_const = "\
  ENDLET\000\
  ADD\000\
  MINUS\000\
  MULT\000\
  DIV\000\
  MOD\000\
  UMINUS\000\
  PRINT\000\
  POP\000\
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
  FUNCT\000\
  RETURN\000\
  CALL\000\
  "

let yynames_block = "\
  INT\000\
  LET\000\
  ACCESS\000\
  LETREC\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instrl) in
    Obj.repr(
# 27 "parsMachine.mly"
                                                    ( _1 )
# 168 "parsMachine.ml"
               : Machine.instruction list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 30 "parsMachine.mly"
                 ( [_1] )
# 175 "parsMachine.ml"
               : 'instrl))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instrl) in
    Obj.repr(
# 31 "parsMachine.mly"
                       ( _1::_2 )
# 183 "parsMachine.ml"
               : 'instrl))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'instrl) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'instrl) in
    Obj.repr(
# 35 "parsMachine.mly"
                                     ( IF(_2,_4) )
# 191 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 36 "parsMachine.mly"
                   ( INT(_1) )
# 198 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 38 "parsMachine.mly"
                   ( ADD )
# 204 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "parsMachine.mly"
                   ( MINUS )
# 210 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 40 "parsMachine.mly"
                  ( MULT )
# 216 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 41 "parsMachine.mly"
                 ( DIV )
# 222 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 42 "parsMachine.mly"
                 ( MOD )
# 228 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 43 "parsMachine.mly"
                   ( UMINUS )
# 234 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 44 "parsMachine.mly"
                   ( PRINT )
# 240 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 45 "parsMachine.mly"
                 ( POP )
# 246 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 47 "parsMachine.mly"
                 ( AND )
# 252 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 48 "parsMachine.mly"
                ( OR )
# 258 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 49 "parsMachine.mly"
                   ( EQUAL )
# 264 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 50 "parsMachine.mly"
                   ( NEQUAL )
# 270 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 51 "parsMachine.mly"
                   ( INFEQ )
# 276 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 52 "parsMachine.mly"
                 ( INF )
# 282 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 53 "parsMachine.mly"
                   ( SUPEQ )
# 288 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 54 "parsMachine.mly"
                 ( SUP )
# 294 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 56 "parsMachine.mly"
                 ( LET(_1) )
# 301 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 57 "parsMachine.mly"
                   ( ACCESS(_1) )
# 308 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 58 "parsMachine.mly"
                   ( ENDLET )
# 314 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'instrl) in
    Obj.repr(
# 60 "parsMachine.mly"
                             ( FUNCT(_2@[RETURN]) )
# 321 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 61 "parsMachine.mly"
                  ( CALL )
# 327 "parsMachine.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 62 "parsMachine.mly"
                   ( LETREC(_1) )
# 334 "parsMachine.ml"
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
