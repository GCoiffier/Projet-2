open Formula
open Visited

module type BDD_Sig =
  sig
      type bdd

      val create : formula -> bdd
      (* Creates the canonical ROBDD associated with a formula *)

      val satisfy : bdd -> bool* 'a list
      (* Tests the satisfiability of the formula. If it is satisfiable,
        also return the list of variables that are set to true (returns [] if
        not satisfiable)
      *)

      val nb_node : bdd -> int

      val print : bdd -> string -> unit
      (* Exports a .dot file representing the BDD *)
  end
