open Formula.Formula

module type BDD_Sig =
  sig
      type 'a bdd
      val build_from_formula : formula -> 'a bdd
      val satisfy : 'a bdd -> bool* 'a list
  end

module BDD =
  struct
    type 'a bdd = Leaf of bool | Node of 'a * 'a bdd * 'a bdd

    let build_from_formula f = 


  end
