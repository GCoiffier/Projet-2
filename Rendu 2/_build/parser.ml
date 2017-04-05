type token =
  | CONST of (int)
  | VARIABLE of (string)
  | ADD
  | MINUS
  | MULT
  | DIV
  | MOD
  | AND
  | OR
  | NOT
  | EGALE
  | NEG
  | SUPS
  | INFS
  | SUPE
  | INFE
  | IF
  | THEN
  | ELSE
  | PRINT
  | LET
  | IN
  | FUN
  | IMPLIES
  | LPAREN
  | RPAREN
  | EOL
  | EINSTR

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
(* --- préambule: ici du code Caml --- *)

open Interpreteur
open Prog_type

# 40 "parser.ml"
let yytransl_const = [|
  259 (* ADD *);
  260 (* MINUS *);
  261 (* MULT *);
  262 (* DIV *);
  263 (* MOD *);
  264 (* AND *);
  265 (* OR *);
  266 (* NOT *);
  267 (* EGALE *);
  268 (* NEG *);
  269 (* SUPS *);
  270 (* INFS *);
  271 (* SUPE *);
  272 (* INFE *);
  273 (* IF *);
  274 (* THEN *);
  275 (* ELSE *);
  276 (* PRINT *);
  277 (* LET *);
  278 (* IN *);
  279 (* FUN *);
  280 (* IMPLIES *);
  281 (* LPAREN *);
  282 (* RPAREN *);
  283 (* EOL *);
  284 (* EINSTR *);
    0|]

let yytransl_block = [|
  257 (* CONST *);
  258 (* VARIABLE *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\003\000\003\000\003\000\003\000\003\000\003\000\000\000"

let yylen = "\002\000\
\002\000\006\000\002\000\006\000\003\000\003\000\004\000\003\000\
\003\000\003\000\003\000\003\000\001\000\001\000\003\000\003\000\
\002\000\003\000\003\000\003\000\003\000\003\000\003\000\001\000\
\003\000\004\000\002\000\002\000\004\000\002\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\014\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\032\000\000\000\000\000\031\000\030\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\001\000\000\000\028\000\027\000\000\000\
\025\000\000\000\000\000\000\000\000\000\005\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\018\000\019\000\020\000\
\021\000\022\000\023\000\000\000\000\000\029\000\000\000\000\000\
\000\000\026\000\000\000\000\000\000\000\000\000"

let yydgoto = "\002\000\
\011\000\012\000\013\000"

let yysindex = "\002\000\
\170\000\000\000\000\000\006\255\170\000\170\000\170\000\002\255\
\004\255\170\000\000\000\090\255\008\255\000\000\000\000\131\000\
\217\000\116\255\193\000\023\255\012\255\134\255\170\000\170\000\
\170\000\170\000\170\000\170\000\170\000\170\000\170\000\170\000\
\170\000\170\000\170\000\000\000\170\000\000\000\000\000\170\000\
\000\000\160\255\170\000\170\000\170\000\000\000\205\000\205\000\
\001\255\001\255\001\255\217\000\217\000\000\000\000\000\000\000\
\000\000\000\000\000\000\193\000\186\255\000\000\212\255\230\255\
\193\000\000\000\170\000\170\000\193\000\001\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\038\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\064\255\000\000\000\000\000\000\
\079\000\000\000\229\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\140\000\157\000\
\015\000\041\000\067\000\100\000\112\000\000\000\000\000\000\000\
\000\000\000\000\000\000\216\000\000\000\000\000\000\000\000\000\
\227\000\000\000\000\000\000\000\238\000\089\255"

let yygindex = "\000\000\
\000\000\251\255\000\000"

let yytablesize = 522
let yytable = "\017\000\
\018\000\019\000\001\000\020\000\022\000\021\000\014\000\015\000\
\038\000\039\000\042\000\030\000\031\000\032\000\033\000\034\000\
\035\000\047\000\048\000\049\000\050\000\051\000\052\000\053\000\
\054\000\055\000\056\000\057\000\058\000\059\000\016\000\060\000\
\040\000\044\000\061\000\045\000\000\000\063\000\064\000\065\000\
\013\000\013\000\013\000\013\000\013\000\013\000\013\000\000\000\
\013\000\013\000\013\000\013\000\013\000\013\000\000\000\013\000\
\013\000\000\000\000\000\013\000\000\000\069\000\070\000\013\000\
\013\000\013\000\024\000\024\000\024\000\024\000\024\000\024\000\
\024\000\000\000\024\000\024\000\024\000\024\000\024\000\024\000\
\000\000\024\000\024\000\000\000\000\000\024\000\000\000\000\000\
\000\000\024\000\024\000\024\000\023\000\024\000\025\000\026\000\
\027\000\028\000\029\000\000\000\030\000\031\000\032\000\033\000\
\034\000\035\000\004\000\004\000\000\000\000\000\004\000\000\000\
\000\000\000\000\004\000\004\000\036\000\037\000\023\000\024\000\
\025\000\026\000\027\000\028\000\029\000\000\000\030\000\031\000\
\032\000\033\000\034\000\035\000\000\000\043\000\000\000\000\000\
\023\000\024\000\025\000\026\000\027\000\028\000\029\000\037\000\
\030\000\031\000\032\000\033\000\034\000\035\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\046\000\
\000\000\037\000\023\000\024\000\025\000\026\000\027\000\028\000\
\029\000\000\000\030\000\031\000\032\000\033\000\034\000\035\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\062\000\000\000\037\000\023\000\024\000\025\000\026\000\
\027\000\028\000\029\000\000\000\030\000\031\000\032\000\033\000\
\034\000\035\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\066\000\000\000\037\000\023\000\024\000\
\025\000\026\000\027\000\028\000\029\000\000\000\030\000\031\000\
\032\000\033\000\034\000\035\000\000\000\000\000\067\000\000\000\
\023\000\024\000\025\000\026\000\027\000\028\000\029\000\037\000\
\030\000\031\000\032\000\033\000\034\000\035\000\003\000\003\000\
\000\000\000\000\003\000\068\000\000\000\000\000\003\000\003\000\
\003\000\037\000\000\000\023\000\024\000\025\000\026\000\027\000\
\028\000\029\000\000\000\030\000\031\000\032\000\033\000\034\000\
\035\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
\000\000\000\000\000\000\000\000\037\000\000\000\000\000\000\000\
\010\000\010\000\000\000\000\000\010\000\000\000\000\000\000\000\
\010\000\010\000\010\000\011\000\011\000\011\000\011\000\011\000\
\011\000\011\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\011\000\011\000\000\000\000\000\011\000\000\000\
\000\000\000\000\011\000\011\000\011\000\012\000\012\000\012\000\
\012\000\012\000\012\000\012\000\000\000\000\000\000\000\000\000\
\000\000\017\000\017\000\000\000\012\000\012\000\017\000\017\000\
\012\000\000\000\000\000\000\000\012\000\012\000\012\000\000\000\
\017\000\017\000\000\000\000\000\017\000\000\000\015\000\015\000\
\017\000\017\000\017\000\015\000\015\000\000\000\000\000\000\000\
\000\000\000\000\016\000\016\000\000\000\015\000\015\000\016\000\
\016\000\015\000\000\000\000\000\000\000\015\000\015\000\015\000\
\000\000\016\000\016\000\003\000\004\000\016\000\000\000\000\000\
\000\000\016\000\016\000\016\000\005\000\000\000\008\000\008\000\
\000\000\000\000\000\000\006\000\000\000\000\000\007\000\008\000\
\000\000\009\000\000\000\010\000\041\000\008\000\008\000\009\000\
\009\000\008\000\000\000\000\000\000\000\008\000\008\000\008\000\
\000\000\000\000\003\000\004\000\000\000\000\000\009\000\009\000\
\000\000\000\000\009\000\005\000\000\000\000\000\009\000\009\000\
\009\000\000\000\006\000\000\000\000\000\007\000\008\000\000\000\
\009\000\000\000\010\000\023\000\024\000\025\000\026\000\027\000\
\028\000\029\000\000\000\030\000\031\000\032\000\033\000\034\000\
\035\000\025\000\026\000\027\000\028\000\029\000\000\000\030\000\
\031\000\032\000\033\000\034\000\035\000\025\000\026\000\027\000\
\000\000\000\000\000\000\030\000\031\000\032\000\033\000\034\000\
\035\000\006\000\006\000\000\000\000\000\006\000\000\000\000\000\
\000\000\006\000\006\000\006\000\007\000\007\000\000\000\000\000\
\007\000\000\000\000\000\000\000\007\000\007\000\007\000\002\000\
\002\000\000\000\000\000\002\000\000\000\000\000\000\000\002\000\
\002\000\002\000"

let yycheck = "\005\000\
\006\000\007\000\001\000\002\001\010\000\002\001\001\001\002\001\
\001\001\002\001\016\000\011\001\012\001\013\001\014\001\015\001\
\016\001\023\000\024\000\025\000\026\000\027\000\028\000\029\000\
\030\000\031\000\032\000\033\000\034\000\035\000\025\001\037\000\
\025\001\011\001\040\000\024\001\255\255\043\000\044\000\045\000\
\003\001\004\001\005\001\006\001\007\001\008\001\009\001\255\255\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\018\001\
\019\001\255\255\255\255\022\001\255\255\067\000\068\000\026\001\
\027\001\028\001\003\001\004\001\005\001\006\001\007\001\008\001\
\009\001\255\255\011\001\012\001\013\001\014\001\015\001\016\001\
\255\255\018\001\019\001\255\255\255\255\022\001\255\255\255\255\
\255\255\026\001\027\001\028\001\003\001\004\001\005\001\006\001\
\007\001\008\001\009\001\255\255\011\001\012\001\013\001\014\001\
\015\001\016\001\018\001\019\001\255\255\255\255\022\001\255\255\
\255\255\255\255\026\001\027\001\027\001\028\001\003\001\004\001\
\005\001\006\001\007\001\008\001\009\001\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\255\255\018\001\255\255\255\255\
\003\001\004\001\005\001\006\001\007\001\008\001\009\001\028\001\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\026\001\
\255\255\028\001\003\001\004\001\005\001\006\001\007\001\008\001\
\009\001\255\255\011\001\012\001\013\001\014\001\015\001\016\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\026\001\255\255\028\001\003\001\004\001\005\001\006\001\
\007\001\008\001\009\001\255\255\011\001\012\001\013\001\014\001\
\015\001\016\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\026\001\255\255\028\001\003\001\004\001\
\005\001\006\001\007\001\008\001\009\001\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\255\255\255\255\019\001\255\255\
\003\001\004\001\005\001\006\001\007\001\008\001\009\001\028\001\
\011\001\012\001\013\001\014\001\015\001\016\001\018\001\019\001\
\255\255\255\255\022\001\022\001\255\255\255\255\026\001\027\001\
\028\001\028\001\255\255\003\001\004\001\005\001\006\001\007\001\
\008\001\009\001\255\255\011\001\012\001\013\001\014\001\015\001\
\016\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\
\255\255\255\255\255\255\255\255\028\001\255\255\255\255\255\255\
\018\001\019\001\255\255\255\255\022\001\255\255\255\255\255\255\
\026\001\027\001\028\001\003\001\004\001\005\001\006\001\007\001\
\008\001\009\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\018\001\019\001\255\255\255\255\022\001\255\255\
\255\255\255\255\026\001\027\001\028\001\003\001\004\001\005\001\
\006\001\007\001\008\001\009\001\255\255\255\255\255\255\255\255\
\255\255\003\001\004\001\255\255\018\001\019\001\008\001\009\001\
\022\001\255\255\255\255\255\255\026\001\027\001\028\001\255\255\
\018\001\019\001\255\255\255\255\022\001\255\255\003\001\004\001\
\026\001\027\001\028\001\008\001\009\001\255\255\255\255\255\255\
\255\255\255\255\003\001\004\001\255\255\018\001\019\001\008\001\
\009\001\022\001\255\255\255\255\255\255\026\001\027\001\028\001\
\255\255\018\001\019\001\001\001\002\001\022\001\255\255\255\255\
\255\255\026\001\027\001\028\001\010\001\255\255\003\001\004\001\
\255\255\255\255\255\255\017\001\255\255\255\255\020\001\021\001\
\255\255\023\001\255\255\025\001\026\001\018\001\019\001\003\001\
\004\001\022\001\255\255\255\255\255\255\026\001\027\001\028\001\
\255\255\255\255\001\001\002\001\255\255\255\255\018\001\019\001\
\255\255\255\255\022\001\010\001\255\255\255\255\026\001\027\001\
\028\001\255\255\017\001\255\255\255\255\020\001\021\001\255\255\
\023\001\255\255\025\001\003\001\004\001\005\001\006\001\007\001\
\008\001\009\001\255\255\011\001\012\001\013\001\014\001\015\001\
\016\001\005\001\006\001\007\001\008\001\009\001\255\255\011\001\
\012\001\013\001\014\001\015\001\016\001\005\001\006\001\007\001\
\255\255\255\255\255\255\011\001\012\001\013\001\014\001\015\001\
\016\001\018\001\019\001\255\255\255\255\022\001\255\255\255\255\
\255\255\026\001\027\001\028\001\018\001\019\001\255\255\255\255\
\022\001\255\255\255\255\255\255\026\001\027\001\028\001\018\001\
\019\001\255\255\255\255\022\001\255\255\255\255\255\255\026\001\
\027\001\028\001"

let yynames_const = "\
  ADD\000\
  MINUS\000\
  MULT\000\
  DIV\000\
  MOD\000\
  AND\000\
  OR\000\
  NOT\000\
  EGALE\000\
  NEG\000\
  SUPS\000\
  INFS\000\
  SUPE\000\
  INFE\000\
  IF\000\
  THEN\000\
  ELSE\000\
  PRINT\000\
  LET\000\
  IN\000\
  FUN\000\
  IMPLIES\000\
  LPAREN\000\
  RPAREN\000\
  EOL\000\
  EINSTR\000\
  "

let yynames_block = "\
  CONST\000\
  VARIABLE\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 39 "parser.mly"
                                              ( _1 )
# 304 "parser.ml"
               : Prog_type.programme))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 42 "parser.mly"
                                           ( IfThenElse(_2,_4,_6) )
# 313 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 43 "parser.mly"
                                 ( PrInt(_2) )
# 320 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 44 "parser.mly"
                                           ( Let(_2,_4,_6) )
# 329 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 45 "parser.mly"
                                        ( _2 )
# 336 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 46 "parser.mly"
                                  ( Imp(_1,_3) )
# 344 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 48 "parser.mly"
                                              ( Function_def(_2, _4) )
# 352 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 51 "parser.mly"
                                   ( BinOp (_1, Add, _3) )
# 360 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 52 "parser.mly"
                                        ( BinOp (_1, Minus, _3) )
# 368 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 53 "parser.mly"
                                       ( BinOp (_1, Mult, _3) )
# 376 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 54 "parser.mly"
                                   ( BinOp (_1, Div, _3) )
# 384 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 55 "parser.mly"
                                   ( BinOp (_1, Mod, _3) )
# 392 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 56 "parser.mly"
                               ( Var(_1) )
# 399 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 57 "parser.mly"
                                ( Const(_1) )
# 406 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 60 "parser.mly"
                                   ( BinOp(_1,And,_3) )
# 414 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 61 "parser.mly"
                                  ( BinOp(_1,Or,_3) )
# 422 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 62 "parser.mly"
                                              ( UnOp(Not,_2) )
# 429 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 63 "parser.mly"
                                     ( BinOp(_1, Equal ,_3) )
# 437 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 64 "parser.mly"
                                   ( BinOp(_1, Neq ,_3) )
# 445 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 65 "parser.mly"
                                    ( BinOp(_1, Sup ,_3) )
# 453 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 66 "parser.mly"
                                    ( BinOp(_1, Inf ,_3) )
# 461 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 67 "parser.mly"
                                    ( BinOp(_1, Supeq ,_3) )
# 469 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 68 "parser.mly"
                                    ( BinOp(_1, Infeq ,_3) )
# 477 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'funct_call) in
    Obj.repr(
# 70 "parser.mly"
                        ( _1 )
# 484 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    Obj.repr(
# 71 "parser.mly"
                                              ( Function_call( Var(_1), Const(1) ) )
# 491 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'funct_call) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 75 "parser.mly"
                                              ( Function_call(_1, _3) )
# 499 "parser.ml"
               : 'funct_call))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'funct_call) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 76 "parser.mly"
                               ( Function_call(_1, Var(_2) ) )
# 507 "parser.ml"
               : 'funct_call))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'funct_call) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 77 "parser.mly"
                             ( Function_call(_1, Const(_2) ) )
# 515 "parser.ml"
               : 'funct_call))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 78 "parser.mly"
                                              ( Function_call( Var(_1), _3) )
# 523 "parser.ml"
               : 'funct_call))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 79 "parser.mly"
                             ( Function_call( Var(_1), Var(_2) ) )
# 531 "parser.ml"
               : 'funct_call))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 80 "parser.mly"
                               ( Function_call( Var(_1), Const(_2) ) )
# 539 "parser.ml"
               : 'funct_call))
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : Prog_type.programme)
