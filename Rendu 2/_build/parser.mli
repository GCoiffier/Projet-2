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

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Fouine.programme
