(* -----------------------------------------
  |    PROJET 2  2017 - L3IF ENS Lyon      |
  |    Valque Léo - Coiffier Guillaume     |
  |                                        |
  |                Main file               |
  ------------------------------------------

  NB : Tout ce qu'il faut savoir est dans le README.md
*)

open Formula
open Bdd
open LexParInterface
open Minisat
open Tseitin
open Argv

let _ = argv_call ();;
