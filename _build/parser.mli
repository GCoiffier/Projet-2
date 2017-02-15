type token =
  | INT of (int)
  | AND
  | OR
  | NEG
  | XOR
  | LPAREN
  | RPAREN
  | EOL

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Formula.formula
