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

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Machine.instruction list
