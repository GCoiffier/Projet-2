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
  | REC
  | LPAREN
  | RPAREN
  | EOL
  | EINSTR
  | TRY
  | WITH
  | EXCEPT
  | RAISE
  | REF
  | AFFECT
  | ACCESS

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Prog_type.programme
