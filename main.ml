open Formula
open Bdd
open LexParInterface

let f1 = read_formula();;
print_formula f1;;
let my_bdd = BDD.create f1;;
print_int (BDD.nb_node my_bdd); print_newline ();;
BDD.print my_bdd "test";;
