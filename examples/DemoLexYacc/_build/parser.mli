type token =
  | INT of (int)
  | PLUS
  | TIMES
  | LPAREN
  | RPAREN
  | EOL

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Expr.expr
