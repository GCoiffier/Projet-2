open Formula
open Valuation

type bdd =  Leaf of bool
          | Node of int * bdd * bdd

module type BDD_Sig =
  sig
      type t

      val create : formula -> t
      (* Creates the canonical ROBDD associated with a formula *)

      val is_leaf : t -> bool -> bool
      (* is_leaf x b is true iff x == Leaf(b) *)

      val satisfy : t -> bool Valuation.t -> bool
      (* Tests the satisfiability of the formula. If it is satisfiable,
        also return the list of variables that are set to true (returns [] if
        not satisfiable)
      *)

      val size : t -> int
      (* BDD size in terms of number of nodes (physical equality) *)

      val print_as_string : t -> unit
      (* displays the BDD as a string *)

      val print : t -> string -> unit
      (* Exports a .dot file representing the BDD *)
  end
