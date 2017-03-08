open Formula
open Visited

module type BDD_Sig =
  sig
      type bdd

      val create : formula -> bdd
      (* Creates the canonical ROBDD associated with a formula *)

      val satisfy : bdd -> bool array -> bool
      (* Tests the satisfiability of the formula. If it is satisfiable,
        also return the list of variables that are set to true (returns [] if
        not satisfiable)
      *)

      val size : bdd -> int

      val print : bdd -> string -> unit
      (* Exports a .dot file representing the BDD *)
  end
