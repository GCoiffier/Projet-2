open Formula
<<<<<<< HEAD
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

let _ = minisat ( reduction_full( tseitin ( read_formula() )));;
=======
open Bdd
open LexParInterface

let f1 = read_formula();;
print_formula f1;;
let my_bdd = BDD.create f1;;
BDD.print my_bdd "test";;
>>>>>>> master
