open Tests
open Formula
open Bdd.BDD
open API

let my_bdd = build_from_formula f1;;
print my_bdd "test";;

let _ = affiche f1;;

let compile e =
  begin
    affiche e;
    print_newline()
  end

let _ = compile( read_formula() );;
