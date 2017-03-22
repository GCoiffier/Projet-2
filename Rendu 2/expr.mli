open Data_structures

module type ArithSig = sig
  type t

  val eval : t -> environnement -> int

end


module type BoolSig = sig
  type t
  val eval : t -> environnement -> bool

end
