module Var = Set.Make(struct
                       type t = int
                       (* use Pervasives compare *)
                       let compare = compare
                      end)

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

let get_variables f =
  (* get the list of variables of f  *)
  let rec get_variables_aux s = function
     Const(k) -> s
    |Var(x) -> (Var.add x s)
    |OR(f1,f2) -> let s2 = (get_variables_aux s f1) in (get_variables_aux s2 f2)
    |AND(f1,f2) -> let s2 = (get_variables_aux s f1) in (get_variables_aux s2 f2)
    |XOR(f1,f2) -> let s2 = (get_variables_aux s f1) in (get_variables_aux s2 f2)
    |NOT(f)-> get_variables_aux s f
    |IMPLIES(f1,f2) -> let s2 = (get_variables_aux s f1) in (get_variables_aux s2 f2)
    |EQUIV(f1,f2) -> let s2 = (get_variables_aux s f1) in (get_variables_aux s2 f2)
  in Var.elements (get_variables_aux Var.empty f);;

let nb_var f = List.length (get_variables f)

let rec eval v f =
  (* given a valuation 'val', ie a vector of booleans,
      computes the value of the formula f *)
    let rec eval_aux = function
      | Const(k) -> k
      | Var(x) -> v.(x)
      | OR (f1,f2) -> (eval_aux f1) || (eval_aux f2)
      | AND (f1,f2) -> (eval_aux f1) && (eval_aux f2)
      | NOT(f1) -> not (eval_aux f1)
      | XOR (f1,f2) -> let v1 = (eval_aux f1) and v2 = (eval_aux f2)
                          in (v1 || v2) && (not (v1 && v2))
      | IMPLIES (f1,f2) -> let v1 = (eval_aux f1) and v2 = (eval_aux f2)
                          in v2 || (not v1)
      | EQUIV (f1,f2) -> let v1 = (eval_aux f1) and v2 = (eval_aux f2)
                          in (v2 && v1) || ( (not v1) && (not v2))
    in eval_aux f
