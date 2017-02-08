(* un type pour des expressions booléennes *)
type formula =
    Const of bool
  | Var of int
  | OR of formula * formula
  | AND of formula * formula
  | NOT of formula
  | XOR of formula * formula
  | IMPLIES of formula * formula
  | EQUIV of formula * formula



(* fonction d'affichage *)
let rec affiche_expr f =
  let aff_aux s a b =
      begin
	print_string s;
	affiche_expr a;
	print_string ", ";
	affiche_expr b;
	print_string ")"
      end
  in
  match f with
    | Const k -> if k then (print_string "True") else (print_string "False")
    | Var x -> print_string "x"^(string_of_int x)
    | OR(f1,f2) -> aff_aux "OR(" f1 f2
    | AND (f1,f2) -> aff_aux "AND(" f1 f2
    | NOT f1 -> "NOT("^(affiche_expr f1)^")"
    | XOR (f1,f2) -> aff_aux "XOR(" f1 f2
    | IMPLIES (f1,f2) -> aff_aux "IMPLIES(" f1 f2
    | EQUIV (f1,f2) -> aff_aux "EQUIV(" f1 f2


let rec eval val f = match f with
  (* given a valuation 'val', computes the value of the formula f *)
  | Const k -> k
  | Var x -> val.(x)
  | OR (f1,f2) -> (eval val f1) || (eval val f2)
  | AND (f1,f2) -> (eval val f1) && (eval val f2)
  | NOT f1 -> not (eval val f1)
  | XOR (f1,f2) -> let v1 = (eval val f1) and v2 = (eval val f2)
                      in (v1 || v2) && ~(v1 && v2)
  | IMPLIES (f1,f2) -> let v1 = (eval val f1) and v2 = (eval val f2)
                      in v2 || ~ v1
  | EQUIV (f1,f2) -> let v1 = (eval val f1) and v2 = (eval val f2)
                      in (v2 && v1) || (~v1 && ~v2)
