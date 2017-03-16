(* Une valuation d'une formule booléenne sera un map où on associera
  à chaque variable (entier) de la formule une valeur booléenne*)
module Valuation = Map.Make(struct
                       type t = int
                       (* use Pervasives compare *)
                       let compare = compare
                      end)

let valuation_from_list l =
(* Convertit une liste de tuples (x,v) en la valuation correspondante *)
  let rec vfl_aux v = function
    |[] -> v
    |(a,b)::q -> let v = vfl_aux v q in
      (Valuation.add a b v)
  in vfl_aux (Valuation.empty) l;;


(* Un set pour stocker des entiers.
    Utilisé dans la fonction get_variables *)
module Var = Set.Make(struct
                       type t = int
                       (* use Pervasives compare *)
                       let compare = compare
                      end)
