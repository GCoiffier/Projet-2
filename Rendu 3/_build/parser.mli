type token =
  | CONST of (int)
  | VARIABLE of (string)
  | TAFFECT of (string)
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
  | PRINT
  | LET
  | IN
  | IF
  | THEN
  | ELSE
  | BEGIN
  | END
  | FUN
  | IMPLIES
  | REC
  | LPAREN
  | RPAREN
  | UNIT
  | EOL
  | EINSTR
  | TRY
  | WITH
  | EXCEPT
  | RAISE
  | REF
  | AFFECT
  | ACCESS
  | UNDERSCORE
  | PRSTR of (string)
  | PRNL
  | AMAKE
  | LARROW

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Prog_type.programme
