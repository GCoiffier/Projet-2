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

# 39 "parser.ml"
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
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\000\000"

let yylen = "\002\000\
\002\000\006\000\002\000\006\000\003\000\003\000\001\000\003\000\
\003\000\003\000\003\000\003\000\003\000\001\000\001\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\015\000\014\000\000\000\000\000\000\000\000\000\
\024\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\005\000\008\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000"

let yydgoto = "\002\000\
\009\000\010\000\013\000\011\000"

let yysindex = "\009\000\
\037\255\000\000\000\000\000\000\002\255\002\255\017\255\037\255\
\000\000\028\255\207\255\002\255\249\254\172\255\207\255\019\255\
\248\254\038\255\000\000\037\255\002\255\002\255\002\255\002\255\
\002\255\038\255\002\255\002\255\037\255\002\255\002\255\002\255\
\002\255\002\255\002\255\002\255\000\000\000\000\012\255\207\255\
\207\255\207\255\207\255\207\255\069\255\069\255\242\254\207\255\
\207\255\207\255\207\255\207\255\207\255\167\255\037\255\037\255\
\012\255\012\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\245\254\000\000\000\000\000\000\181\255\000\000\
\000\000\018\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\055\255\057\255\
\078\255\099\255\120\255\141\255\035\255\042\255\000\000\041\255\
\043\255\173\255\184\255\186\255\188\255\000\000\000\000\000\000\
\076\255\097\255"

let yygindex = "\000\000\
\000\000\248\255\071\000\001\000"

let yytablesize = 214
let yytable = "\017\000\
\027\000\028\000\003\000\004\000\055\000\014\000\015\000\007\000\
\018\000\001\000\029\000\039\000\026\000\020\000\007\000\007\000\
\007\000\037\000\016\000\020\000\047\000\040\000\041\000\042\000\
\043\000\044\000\012\000\014\000\014\000\036\000\048\000\049\000\
\050\000\051\000\052\000\053\000\054\000\003\000\004\000\020\000\
\021\000\022\000\023\000\024\000\025\000\007\000\057\000\058\000\
\018\000\018\000\019\000\019\000\016\000\005\000\019\000\020\000\
\006\000\007\000\018\000\017\000\019\000\008\000\000\000\038\000\
\009\000\009\000\000\000\009\000\009\000\009\000\009\000\009\000\
\009\000\006\000\009\000\009\000\027\000\028\000\009\000\000\000\
\006\000\006\000\009\000\009\000\009\000\010\000\010\000\000\000\
\010\000\010\000\010\000\010\000\010\000\010\000\002\000\010\000\
\010\000\045\000\046\000\010\000\000\000\002\000\002\000\010\000\
\010\000\010\000\011\000\011\000\000\000\011\000\011\000\011\000\
\011\000\011\000\011\000\004\000\011\000\011\000\000\000\000\000\
\011\000\000\000\004\000\004\000\011\000\011\000\011\000\012\000\
\012\000\000\000\012\000\012\000\012\000\012\000\012\000\012\000\
\000\000\012\000\012\000\000\000\000\000\012\000\000\000\000\000\
\000\000\012\000\012\000\012\000\013\000\013\000\000\000\013\000\
\013\000\013\000\013\000\013\000\013\000\000\000\013\000\013\000\
\000\000\000\000\013\000\000\000\000\000\000\000\013\000\013\000\
\013\000\021\000\022\000\023\000\024\000\025\000\021\000\022\000\
\023\000\024\000\025\000\000\000\020\000\020\000\030\000\031\000\
\032\000\033\000\034\000\035\000\056\000\000\000\020\000\021\000\
\021\000\022\000\022\000\023\000\023\000\000\000\000\000\003\000\
\000\000\021\000\000\000\022\000\000\000\023\000\003\000\003\000\
\003\000\021\000\022\000\023\000\024\000\025\000"

let yycheck = "\008\000\
\008\001\009\001\001\001\002\001\019\001\005\000\006\000\019\001\
\008\000\001\000\018\001\020\000\012\000\028\001\026\001\027\001\
\028\001\026\001\002\001\028\001\029\000\021\000\022\000\023\000\
\024\000\025\000\025\001\027\000\028\000\011\001\030\000\031\000\
\032\000\033\000\034\000\035\000\036\000\001\001\002\001\028\001\
\003\001\004\001\005\001\006\001\007\001\028\001\055\000\056\000\
\008\001\009\001\008\001\009\001\018\001\017\001\027\001\028\001\
\020\001\021\001\018\001\018\001\018\001\025\001\255\255\026\001\
\008\001\009\001\255\255\011\001\012\001\013\001\014\001\015\001\
\016\001\019\001\018\001\019\001\008\001\009\001\022\001\255\255\
\026\001\027\001\026\001\027\001\028\001\008\001\009\001\255\255\
\011\001\012\001\013\001\014\001\015\001\016\001\019\001\018\001\
\019\001\027\000\028\000\022\001\255\255\026\001\027\001\026\001\
\027\001\028\001\008\001\009\001\255\255\011\001\012\001\013\001\
\014\001\015\001\016\001\019\001\018\001\019\001\255\255\255\255\
\022\001\255\255\026\001\027\001\026\001\027\001\028\001\008\001\
\009\001\255\255\011\001\012\001\013\001\014\001\015\001\016\001\
\255\255\018\001\019\001\255\255\255\255\022\001\255\255\255\255\
\255\255\026\001\027\001\028\001\008\001\009\001\255\255\011\001\
\012\001\013\001\014\001\015\001\016\001\255\255\018\001\019\001\
\255\255\255\255\022\001\255\255\255\255\255\255\026\001\027\001\
\028\001\003\001\004\001\005\001\006\001\007\001\003\001\004\001\
\005\001\006\001\007\001\255\255\008\001\009\001\011\001\012\001\
\013\001\014\001\015\001\016\001\022\001\255\255\018\001\008\001\
\009\001\008\001\009\001\008\001\009\001\255\255\255\255\019\001\
\255\255\018\001\255\255\018\001\255\255\018\001\026\001\027\001\
\028\001\003\001\004\001\005\001\006\001\007\001"

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
# 30 "parser.mly"
                            ( _1 )
# 220 "parser.ml"
               : Fouine.programme))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'bexpr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'instr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 33 "parser.mly"
                                      ( IfThenElse(_2,_4,_6) )
# 229 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 34 "parser.mly"
                                    ( PrInt(_2) )
# 236 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 35 "parser.mly"
                                       ( Imp( Let(_2,_4) ,_6) )
# 245 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    Obj.repr(
# 36 "parser.mly"
                                     ( _2 )
# 252 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'instr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 37 "parser.mly"
                                    ( Imp(_1,_3) )
# 260 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 41 "parser.mly"
              ( _1 )
# 267 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'aexpr) in
    Obj.repr(
# 44 "parser.mly"
                            ( _2 )
# 274 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 45 "parser.mly"
                       ( Plus(_1,_3) )
# 282 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 46 "parser.mly"
                         ( Minus(_1,_3) )
# 290 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 47 "parser.mly"
                        ( Mult(_1,_3) )
# 298 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 48 "parser.mly"
                       ( Div(_1,_3) )
# 306 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 49 "parser.mly"
                       ( MOD(_1,_3) )
# 314 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 50 "parser.mly"
                 ( Var(_1) )
# 321 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 51 "parser.mly"
              ( Const(_1) )
# 328 "parser.ml"
               : 'aexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'bexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'bexpr) in
    Obj.repr(
# 56 "parser.mly"
                       ( And(_1,_3) )
# 336 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'bexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'bexpr) in
    Obj.repr(
# 57 "parser.mly"
                      ( Or(_1,_3) )
# 344 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 59 "parser.mly"
                         ( Comp(_1, Equal ,_3) )
# 352 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 60 "parser.mly"
                         ( Comp(_1, Neq ,_3) )
# 360 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 61 "parser.mly"
                        ( Comp(_1, Sup ,_3) )
# 368 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 62 "parser.mly"
                        ( Comp(_1, Inf ,_3) )
# 376 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 63 "parser.mly"
                        ( Comp(_1, Supeq ,_3) )
# 384 "parser.ml"
               : 'bexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexpr) in
    Obj.repr(
# 64 "parser.mly"
                        ( Comp(_1, Infeq ,_3) )
# 392 "parser.ml"
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
