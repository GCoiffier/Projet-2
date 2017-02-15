type token =
  | INT of (int)
  | AND
  | OR
  | NEG
  | XOR
  | IMP
  | EQ
  | MINUS
  | LPAREN
  | RPAREN
  | EOL

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Formula.formula
