open Formula
open Bdd.BDD
open LexParInterface
open Minisat
open Tseitin
open Argv

let _ = truc ();;


let f1 = read_formula "input.txt";;
print_formula f1;;
let my_bdd = BDD.create f1;;
print_string "BDD size : "; print_int (BDD.size my_bdd); print_newline ();;
BDD.print my_bdd "test";;
