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

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Machine.instruction list
