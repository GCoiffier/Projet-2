module type Expr = sig
  type t
  type content
  val eval : t -> content
end
