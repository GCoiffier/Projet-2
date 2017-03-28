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
  | EQ
  | NEQ
  | SUP
  | INF
  | SUPEQ
  | INFEQ
  | IF
  | THEN
  | ELSE
  | PRINT
  | LET
  | IN
  | LPAREN
  | RPAREN
  | EOL
  | EINSTR

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
(* --- pr�ambule: ici du code Caml --- *)

open Fouine

# 37 "parser.ml"
let yytransl_const = [|
  259 (* ADD *);
  260 (* MINUS *);
  261 (* MULT *);
  262 (* DIV *);
  263 (* MOD *);
  264 (* AND *);
  265 (* OR *);
  266 (* NOT *);
  267 (* EQ *);
  268 (* NEQ *);
  269 (* SUP *);
  270 (* INF *);
  271 (* SUPEQ *);
  272 (* INFEQ *);
  273 (* IF *);
  274 (* THEN *);
  275 (* ELSE *);
  276 (* PRINT *);
  277 (* LET *);
  278 (* IN *);
  279 (* LPAREN *);
  280 (* RPAREN *);
  281 (* EOL *);
  282 (* EINSTR *);
    0|]

let yytransl_block = [|
  257 (* CONST *);
  258 (* VARIABLE *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\004\000\004\000\000\000"

let yylen = "\002\000\
\002\000\006\000\002\000\006\000\003\000\003\000\006\000\001\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\002\000\003\000\003\000\003\000\003\000\003\000\003\000\001\000\
\001\000\002\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\028\000\000\000\000\000\025\000\000\000\026\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\001\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\005\000\009\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000"

let yydgoto = "\002\000\
\009\000\010\000\011\000\012\000"

let yysindex = "\003\000\
\000\255\000\000\017\255\004\255\004\255\004\255\023\255\000\255\
\000\000\048\255\182\255\000\000\017\255\000\000\004\255\182\255\
\166\255\182\255\007\255\252\254\235\254\101\255\000\000\000\255\
\004\255\004\255\004\255\004\255\004\255\004\255\004\255\004\255\
\004\255\004\255\004\255\004\255\004\255\101\255\000\255\004\255\
\004\255\000\000\000\000\002\255\182\255\182\255\182\255\182\255\
\182\255\182\255\182\255\182\255\182\255\182\255\182\255\182\255\
\182\255\238\254\115\255\135\255\000\255\000\255\000\255\002\255\
\002\255\002\255"

let yyrindex = "\000\000\
\000\000\000\000\053\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\026\255\000\000\077\255\000\000\000\000\141\255\
\000\000\037\000\000\000\000\000\000\000\020\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\005\255\181\255\190\255\199\255\208\255\
\217\255\226\255\235\255\244\255\253\255\006\000\015\000\024\000\
\033\000\000\000\000\000\000\000\000\000\000\000\000\000\041\000\
\045\000\048\000"

let yygindex = "\000\000\
\000\000\248\255\007\000\149\000"

let yytablesize = 329
let yytable = "\021\000\
\061\000\003\000\042\000\001\000\024\000\003\000\041\000\024\000\
\013\000\004\000\016\000\017\000\018\000\004\000\022\000\044\000\
\005\000\040\000\013\000\006\000\007\000\038\000\008\000\006\000\
\019\000\000\000\015\000\024\000\006\000\006\000\058\000\045\000\
\046\000\047\000\048\000\049\000\050\000\051\000\052\000\053\000\
\054\000\055\000\056\000\057\000\008\000\008\000\059\000\060\000\
\000\000\008\000\008\000\008\000\064\000\065\000\066\000\024\000\
\024\000\024\000\024\000\024\000\024\000\024\000\000\000\024\000\
\024\000\024\000\024\000\024\000\024\000\000\000\024\000\024\000\
\023\000\024\000\024\000\000\000\024\000\024\000\024\000\027\000\
\027\000\027\000\027\000\027\000\027\000\027\000\000\000\027\000\
\027\000\027\000\027\000\027\000\027\000\000\000\027\000\027\000\
\000\000\000\000\027\000\000\000\027\000\027\000\027\000\025\000\
\026\000\027\000\028\000\029\000\030\000\031\000\000\000\032\000\
\033\000\034\000\035\000\036\000\037\000\025\000\026\000\027\000\
\028\000\029\000\030\000\031\000\043\000\032\000\033\000\034\000\
\035\000\036\000\037\000\000\000\000\000\000\000\000\000\000\000\
\062\000\025\000\026\000\027\000\028\000\029\000\030\000\031\000\
\000\000\032\000\033\000\034\000\035\000\036\000\037\000\014\000\
\000\000\000\000\000\000\020\000\063\000\000\000\017\000\017\000\
\000\000\014\000\017\000\000\000\017\000\017\000\017\000\014\000\
\025\000\026\000\027\000\028\000\029\000\030\000\031\000\000\000\
\032\000\033\000\034\000\035\000\036\000\037\000\000\000\039\000\
\025\000\026\000\027\000\028\000\029\000\030\000\031\000\000\000\
\032\000\033\000\034\000\035\000\036\000\037\000\010\000\010\000\
\000\000\000\000\010\000\000\000\010\000\010\000\010\000\011\000\
\011\000\000\000\000\000\011\000\000\000\011\000\011\000\011\000\
\012\000\012\000\000\000\000\000\012\000\000\000\012\000\012\000\
\012\000\013\000\013\000\000\000\000\000\013\000\000\000\013\000\
\013\000\013\000\014\000\014\000\000\000\000\000\014\000\000\000\
\014\000\014\000\014\000\015\000\015\000\000\000\000\000\015\000\
\000\000\015\000\015\000\015\000\016\000\016\000\000\000\000\000\
\016\000\000\000\016\000\016\000\016\000\018\000\018\000\000\000\
\000\000\018\000\000\000\018\000\018\000\018\000\019\000\019\000\
\000\000\000\000\019\000\000\000\019\000\019\000\019\000\020\000\
\020\000\000\000\000\000\020\000\000\000\020\000\020\000\020\000\
\021\000\021\000\000\000\000\000\021\000\000\000\021\000\021\000\
\021\000\022\000\022\000\000\000\000\000\022\000\000\000\022\000\
\022\000\022\000\023\000\023\000\000\000\000\000\023\000\003\000\
\023\000\023\000\023\000\002\000\003\000\003\000\003\000\004\000\
\002\000\002\000\007\000\000\000\004\000\004\000\000\000\007\000\
\007\000"

let yycheck = "\008\000\
\019\001\002\001\024\001\001\000\026\001\002\001\011\001\026\001\
\002\001\010\001\004\000\005\000\006\000\010\001\008\000\024\000\
\017\001\011\001\002\001\020\001\021\001\015\000\023\001\019\001\
\002\001\255\255\023\001\026\001\024\001\025\001\039\000\025\000\
\026\000\027\000\028\000\029\000\030\000\031\000\032\000\033\000\
\034\000\035\000\036\000\037\000\019\001\026\001\040\000\041\000\
\255\255\024\001\025\001\026\001\061\000\062\000\063\000\003\001\
\004\001\005\001\006\001\007\001\008\001\009\001\255\255\011\001\
\012\001\013\001\014\001\015\001\016\001\255\255\018\001\019\001\
\025\001\026\001\022\001\255\255\024\001\025\001\026\001\003\001\
\004\001\005\001\006\001\007\001\008\001\009\001\255\255\011\001\
\012\001\013\001\014\001\015\001\016\001\255\255\018\001\019\001\
\255\255\255\255\022\001\255\255\024\001\025\001\026\001\003\001\
\004\001\005\001\006\001\007\001\008\001\009\001\255\255\011\001\
\012\001\013\001\014\001\015\001\016\001\003\001\004\001\005\001\
\006\001\007\001\008\001\009\001\024\001\011\001\012\001\013\001\
\014\001\015\001\016\001\255\255\255\255\255\255\255\255\255\255\
\022\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\
\255\255\011\001\012\001\013\001\014\001\015\001\016\001\003\000\
\255\255\255\255\255\255\007\000\022\001\255\255\018\001\019\001\
\255\255\013\000\022\001\255\255\024\001\025\001\026\001\019\000\
\003\001\004\001\005\001\006\001\007\001\008\001\009\001\255\255\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\018\001\
\003\001\004\001\005\001\006\001\007\001\008\001\009\001\255\255\
\011\001\012\001\013\001\014\001\015\001\016\001\018\001\019\001\
\255\255\255\255\022\001\255\255\024\001\025\001\026\001\018\001\
\019\001\255\255\255\255\022\001\255\255\024\001\025\001\026\001\
\018\001\019\001\255\255\255\255\022\001\255\255\024\001\025\001\
\026\001\018\001\019\001\255\255\255\255\022\001\255\255\024\001\
\025\001\026\001\018\001\019\001\255\255\255\255\022\001\255\255\
\024\001\025\001\026\001\018\001\019\001\255\255\255\255\022\001\
\255\255\024\001\025\001\026\001\018\001\019\001\255\255\255\255\
\022\001\255\255\024\001\025\001\026\001\018\001\019\001\255\255\
\255\255\022\001\255\255\024\001\025\001\026\001\018\001\019\001\
\255\255\255\255\022\001\255\255\024\001\025\001\026\001\018\001\
\019\001\255\255\255\255\022\001\255\255\024\001\025\001\026\001\
\018\001\019\001\255\255\255\255\022\001\255\255\024\001\025\001\
\026\001\018\001\019\001\255\255\255\255\022\001\255\255\024\001\
\025\001\026\001\018\001\019\001\255\255\255\255\022\001\019\001\
\024\001\025\001\026\001\019\001\024\001\025\001\026\001\019\001\
\024\001\025\001\019\001\255\255\024\001\025\001\255\255\024\001\
\025\001"

let yynames_const = "\
  ADD\000\
  MINUS\000\
  MULT\000\
  DIV\000\
  MOD\000\
  AND\000\
  OR\000\
  NOT\000\
  EQ\000\
  NEQ\000\
  SUP\000\
  INF\000\
  SUPEQ\000\
  INFEQ\000\
  IF\000\
  THEN\000\
  ELSE\000\
  PRINT\000\
  LET\000\
  IN\000\
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
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    Obj.repr(
# 29 "parser.mly"
                             ( _1 )
# 249 "parser.ml"
               : Fouine.programme))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'instr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 32 "parser.mly"
                                   ( IfThenElse(_2,_4,_6) )
# 258 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 33 "parser.mly"
                   ( )
# 265 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 34 "parser.mly"
                                   ( Imp( Let(_2,_4) ,_6) )
# 274 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    Obj.repr(
# 35 "parser.mly"
                           ( _2 )
# 281 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'instr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 36 "parser.mly"
                          ( Imp(_1,_3) )
# 289 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'funct) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 38 "parser.mly"
                                ( Imp( Function(_2,_4) ,_6) )
# 298 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "parser.mly"
             ( _1 )
# 305 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 42 "parser.mly"
                           ( _2 )
# 312 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 43 "parser.mly"
                     ( Plus(_1,_3) )
# 320 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 44 "parser.mly"
                       ( Minus(_1,_3) )
# 328 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 45 "parser.mly"
                      ( Mult(_1,_3) )
# 336 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 46 "parser.mly"
                     ( Div(_1,_3) )
# 344 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 47 "parser.mly"
                     ( Mod(_1,_3) )
# 352 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 49 "parser.mly"
                     ( And(_1,_3) )
# 360 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 50 "parser.mly"
                    ( Or(_1,_3) )
# 368 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 51 "parser.mly"
                        ( Not(_2) )
# 375 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 52 "parser.mly"
                      ( Comp(_1, Equal ,_3) )
# 383 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 53 "parser.mly"
                       ( Comp(_1, Neq ,_3) )
# 391 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 54 "parser.mly"
                       ( Comp(_1, Sup ,_3) )
# 399 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 55 "parser.mly"
                       ( Comp(_1, Inf ,_3) )
# 407 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 56 "parser.mly"
                       ( Comp(_1, Supeq ,_3) )
# 415 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 57 "parser.mly"
                       ( Comp(_1, Infeq ,_3) )
# 423 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 58 "parser.mly"
                 ( Const(_1) )
# 430 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'funct) in
    Obj.repr(
# 60 "parser.mly"
              ( EVFUN(_1) )
# 437 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'funct) in
    Obj.repr(
# 63 "parser.mly"
                      ( FUN(_1,_2) )
# 445 "parser.ml"
               : 'funct))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 64 "parser.mly"
                         ( FUN(_1,_2) )
# 453 "parser.ml"
               : 'funct))
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : Fouine.programme)
