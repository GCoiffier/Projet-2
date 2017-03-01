open Tests
open Formula
open Bdd.BDD
open API
open Minisat
open Tseitin

let my_bdd = build_from_formula f1;;
print my_bdd "test";;

let _ = affiche f1;;

let compile e =
  begin
    affiche e;
    print_newline()
  end

let _ = print_for_minisat ( reduction_full( tseitin ( read_formula() )));;
