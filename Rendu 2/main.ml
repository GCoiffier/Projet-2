(* -----------------------------------------
  |    PROJET 2  2017 - L3IF ENS Lyon      |
  |    Valque Léo - Coiffier Guillaume     |
  |                                        |
  |                 Rendu 2                |
  |                Main file               |
  ------------------------------------------

  NB : Tout ce qu'il faut savoir est dans le README.md
*)

open Interpreteur
open Debug
open LexParInterface

(* main : unit -> unit
	Fonction principale : lit les arguments donnés au programme et appelle les parties du code correspondantes *)
let main () =
	let t = Sys.argv in
	let n = Array.length t in
	match t.(1) with
	|"-debug" ->  (* affiche le code *)
                  let p = read_prgm t.(n-1) in
				  debug p; print_newline ();
                  print_string "result = "; print_int (execute p);
                  print_newline ();

	|"-machine" -> (* compile et execute sur machine à pile *)
					print_string "Option non implémentée";
					print_newline ();

	|"-interm" ->  (* compile vers machine à pile mais n'execute pas : affiche le code *)
					print_string "Option non implémentée";
					print_newline ();

	|_ ->  (* interpréteur simple*)
					let p = read_prgm t.(n-1) in
							print_int (execute p); print_newline ()


let _ = main ();;
