open Formula
open Bdd
open API

let f1 = AND( Var(1) , XOR( AND( Var(2), Var(3)), NOT(Var(4))));;

let my_bdd = BDD.create f1;;
BDD.print my_bdd "test";;

let _ = compile( read_formula() );;
