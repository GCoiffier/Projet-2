(* -----------------------------------------
  |    PROJET 2  2017 - L3IF ENS Lyon      |
  |    Valque Léo - Coiffier Guillaume     |
  |                                        |
  |                 Rendu 2                |
  |                Main file               |
  ------------------------------------------

  NB : Tout ce qu'il faut savoir est dans le README.md
*)

open Argv
open LexParInterface
open Fouine

let p = read_prgm "prog.fouine";;
print_int (execute p); print_newline ();;

(* let _ = argv_call ();; *)
