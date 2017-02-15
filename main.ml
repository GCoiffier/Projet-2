open Tests
open Formula
open Bdd.BDD

let my_bdd = build_from_formula f1;;
print my_bdd "test";;

let _ = affiche f1;;
