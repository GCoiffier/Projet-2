open Formula
open Bdd
open API

let f1 = read_formula();;
let f2 = AND( Var(1) , XOR( AND( Var(2), Var(3)), NOT(Var(4))));;
print_string "coucou";;
let my_bdd = BDD.create f1;;
BDD.print my_bdd "test";;
