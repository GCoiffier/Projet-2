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
let affiche f =
  let rec affiche_expr f =
    let aff_aux s a b =
        begin
    print_string s;
    affiche_expr a;
    print_string ", ";
    affiche_expr b;
    print_string ")"
        end
    in match f with
      | Const(k) -> if k then (print_string "True") else (print_string "False")
      | Var(x) -> print_string ("x"^(string_of_int x))
      | OR(f1,f2) -> aff_aux "OR(" f1 f2
      | AND (f1,f2) -> aff_aux "AND(" f1 f2
      | NOT(f1) -> print_string "NOT(";
	           affiche_expr f1;
	           print_string ")"
      | XOR (f1,f2) -> aff_aux "XOR(" f1 f2
      | IMPLIES (f1,f2) -> aff_aux "IMPLIES(" f1 f2
      | EQUIV (f1,f2) -> aff_aux "EQUIV(" f1 f2
  in
  affiche_expr f; print_newline ();;

let nb_var f =
  (* count the number of variables of f. Variables should be 1 to n. *)
  let rec nb_var_aux m f = match f with
     Const(k) -> m
    |Var(x) -> if x>m then x else m
    |OR(f1,f2) -> max (nb_var_aux m f1) (nb_var_aux m f2)
    |AND(f1,f2) -> max (nb_var_aux m f1) (nb_var_aux m f2)
    |XOR(f1,f2) -> max (nb_var_aux m f1) (nb_var_aux m f2)
    |NOT(f)-> nb_var_aux m f
    |IMPLIES(f1,f2) -> max (nb_var_aux m f1) (nb_var_aux m f2)
    |EQUIV(f1,f2) -> max (nb_var_aux m f1) (nb_var_aux m f2)
  in nb_var_aux 0 f;;

let rec eval v f = match f with
  (* given a valuation 'val', ie a vector of booleans,
      computes the value of the formula f *)
  | Const(k) -> k
  | Var(x) -> v.(x)
  | OR (f1,f2) -> (eval v f1) || (eval v f2)
  | AND (f1,f2) -> (eval v f1) && (eval v f2)
  | NOT(f1) -> not (eval v f1)
  | XOR (f1,f2) -> let v1 = (eval v f1) and v2 = (eval v f2)
                      in (v1 || v2) && (not (v1 && v2))
  | IMPLIES (f1,f2) -> let v1 = (eval v f1) and v2 = (eval v f2)
                      in v2 || (not v1)
  | EQUIV (f1,f2) -> let v1 = (eval v f1) and v2 = (eval v f2)
                      in (v2 && v1) || ( (not v1) && (not v2))
