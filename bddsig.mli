open Formula
open Visited

module type BDD_Sig =
  sig
      type bdd

      val create : formula -> bdd
      (* Creates the canonical ROBDD associated with a formula *)

      val create_without_compression : formula -> bdd
      (* Creates a decision tree associated with formula, without any compression and memory sharing *)

      val satisfy : bdd -> bool* 'a list
      (* Tests the satisfiability of the formula. If it is satisfiable,
        also return the list of variables that are set to true (returns [] if
        not satisfiable)
      *)

      val print : bdd -> string -> unit
      (* Exports a .dot file representing the BDD *)
  end
