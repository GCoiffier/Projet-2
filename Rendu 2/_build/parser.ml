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

open Fouine
open Expr_arith
open Expr_bool

# 41 "parser.ml"
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
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\004\000\
\004\000\004\000\004\000\004\000\004\000\004\000\004\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\000\000"

let yylen = "\002\000\
\002\000\006\000\002\000\006\000\003\000\003\000\001\000\003\000\
\003\000\003\000\003\000\003\000\003\000\001\000\001\000\003\000\
\003\000\002\000\003\000\003\000\003\000\003\000\003\000\003\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\015\000\014\000\000\000\000\000\000\000\000\000\
\025\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\
\000\000\000\000\018\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\005\000\008\000\
\000\000\000\000\000\000\011\000\012\000\013\000\016\000\017\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000"

let yydgoto = "\002\000\
\009\000\010\000\014\000\011\000"

let yysindex = "\002\000\
\083\255\000\000\000\000\000\000\014\255\010\255\008\255\083\255\
\000\000\235\254\170\255\014\255\010\255\093\255\110\255\170\255\
\006\255\038\255\037\255\000\000\083\255\010\255\010\255\010\255\
\010\255\010\255\000\000\037\255\014\255\014\255\083\255\010\255\
\010\255\010\255\010\255\010\255\010\255\010\255\000\000\000\000\
\255\254\031\255\031\255\000\000\000\000\000\000\000\000\000\000\
\242\254\170\255\170\255\170\255\170\255\170\255\170\255\090\255\
\083\255\083\255\255\254\255\254"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\128\255\000\000\000\000\000\000\000\000\131\255\
\000\000\000\000\017\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\134\255\043\255\064\255\000\000\000\000\000\000\000\000\000\000\
\000\000\101\255\119\255\121\255\123\255\125\255\127\255\000\000\
\000\000\000\000\143\255\145\255"

let yygindex = "\000\000\
\000\000\248\255\069\000\252\255"

let yytablesize = 177
let yytable = "\018\000\
\015\000\016\000\001\000\019\000\057\000\020\000\021\000\015\000\
\028\000\017\000\003\000\004\000\041\000\021\000\003\000\004\000\
\038\000\042\000\043\000\044\000\045\000\046\000\049\000\012\000\
\015\000\015\000\021\000\050\000\051\000\052\000\053\000\054\000\
\055\000\056\000\013\000\024\000\025\000\026\000\013\000\022\000\
\023\000\024\000\025\000\026\000\007\000\009\000\009\000\000\000\
\059\000\060\000\009\000\009\000\000\000\009\000\009\000\009\000\
\009\000\009\000\009\000\000\000\009\000\009\000\040\000\039\000\
\009\000\021\000\010\000\010\000\009\000\009\000\009\000\010\000\
\010\000\000\000\010\000\010\000\010\000\010\000\010\000\010\000\
\027\000\010\000\010\000\003\000\004\000\010\000\000\000\000\000\
\000\000\010\000\010\000\010\000\022\000\023\000\024\000\025\000\
\026\000\047\000\048\000\005\000\029\000\030\000\006\000\007\000\
\000\000\000\000\000\000\008\000\019\000\019\000\031\000\058\000\
\022\000\023\000\024\000\025\000\026\000\000\000\019\000\000\000\
\032\000\033\000\034\000\035\000\036\000\037\000\020\000\020\000\
\021\000\021\000\022\000\022\000\023\000\023\000\024\000\024\000\
\020\000\000\000\021\000\000\000\022\000\000\000\023\000\000\000\
\024\000\000\000\007\000\000\000\000\000\003\000\000\000\000\000\
\006\000\007\000\007\000\007\000\003\000\003\000\003\000\006\000\
\006\000\002\000\000\000\004\000\000\000\000\000\000\000\000\000\
\002\000\002\000\004\000\004\000\022\000\023\000\024\000\025\000\
\026\000"

let yycheck = "\008\000\
\005\000\006\000\001\000\008\000\019\001\027\001\028\001\012\000\
\013\000\002\001\001\001\002\001\021\000\028\001\001\001\002\001\
\011\001\022\000\023\000\024\000\025\000\026\000\031\000\010\001\
\029\000\030\000\028\001\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\025\001\005\001\006\001\007\001\025\001\003\001\
\004\001\005\001\006\001\007\001\028\001\003\001\004\001\255\255\
\057\000\058\000\008\001\009\001\255\255\011\001\012\001\013\001\
\014\001\015\001\016\001\255\255\018\001\019\001\026\001\026\001\
\022\001\028\001\003\001\004\001\026\001\027\001\028\001\008\001\
\009\001\255\255\011\001\012\001\013\001\014\001\015\001\016\001\
\012\000\018\001\019\001\001\001\002\001\022\001\255\255\255\255\
\255\255\026\001\027\001\028\001\003\001\004\001\005\001\006\001\
\007\001\029\000\030\000\017\001\008\001\009\001\020\001\021\001\
\255\255\255\255\255\255\025\001\008\001\009\001\018\001\022\001\
\003\001\004\001\005\001\006\001\007\001\255\255\018\001\255\255\
\011\001\012\001\013\001\014\001\015\001\016\001\008\001\009\001\
\008\001\009\001\008\001\009\001\008\001\009\001\008\001\009\001\
\018\001\255\255\018\001\255\255\018\001\255\255\018\001\255\255\
\018\001\255\255\019\001\255\255\255\255\019\001\255\255\255\255\
\019\001\026\001\027\001\028\001\026\001\027\001\028\001\026\001\
\027\001\019\001\255\255\019\001\255\255\255\255\255\255\255\255\
\026\001\027\001\026\001\027\001\003\001\004\001\005\001\006\001\
\007\001"

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
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    Obj.repr(
# 33 "parser.mly"
                            ( _1 )
# 216 "parser.ml"
               : Fouine.programme))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'bexpr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'instr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 36 "parser.mly"
                                      ( IfThenElse(_2,_4,_6) )
# 225 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 37 "parser.mly"
                                    ( PrInt(_2) )
# 232 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 38 "parser.mly"
                                       ( Let(_2,_4,_6) )
# 241 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    Obj.repr(
# 39 "parser.mly"
                                     ( _2 )
# 248 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'instr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 40 "parser.mly"
                                    ( Imp(_1,_3) )
# 256 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 44 "parser.mly"
              ( Arith(_1) )
# 263 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'aexpr) in
    Obj.repr(
# 47 "parser.mly"
                            ( _2 )
# 270 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 48 "parser.mly"
                       ( Plus(_1,_3) )
# 278 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 49 "parser.mly"
                         ( Minus(_1,_3) )
# 286 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 50 "parser.mly"
                        ( Mult(_1,_3) )
# 294 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 51 "parser.mly"
                       ( Div(_1,_3) )
# 302 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 52 "parser.mly"
                       ( Mod(_1,_3) )
# 310 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 53 "parser.mly"
                 ( Var(_1) )
# 317 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 54 "parser.mly"
              ( Const(_1) )
# 324 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'bexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'bexpr) in
    Obj.repr(
# 59 "parser.mly"
                         ( And(_1,_3) )
# 332 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'bexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'bexpr) in
    Obj.repr(
# 60 "parser.mly"
                        ( Or(_1,_3) )
# 340 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'bexpr) in
    Obj.repr(
# 61 "parser.mly"
                            ( Not(_2) )
# 347 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 62 "parser.mly"
                         ( Comp(_1, Equal ,_3) )
# 355 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 63 "parser.mly"
                         ( Comp(_1, Neq ,_3) )
# 363 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 64 "parser.mly"
                        ( Comp(_1, Sup ,_3) )
# 371 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 65 "parser.mly"
                        ( Comp(_1, Inf ,_3) )
# 379 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 66 "parser.mly"
                        ( Comp(_1, Supeq ,_3) )
# 387 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 67 "parser.mly"
                        ( Comp(_1, Infeq ,_3) )
# 395 "parser.ml"
               : 'bexpr))
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
