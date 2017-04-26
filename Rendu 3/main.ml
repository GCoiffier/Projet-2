(* -----------------------------------------
  |    PROJET 2  2017 - L3IF ENS Lyon      |
  |    Valque Léo - Coiffier Guillaume     |
  |                                        |
  |                 Rendu 3                |
  |                Main file               |
  ------------------------------------------

  NB : Tout ce qu'il faut savoir est dans le README.md
*)

open Interpreteur
open Debug
open LexParInterface
open Machine

(* main : unit -> unit
	Fonction principale : lit les arguments donnés au programme et appelle les parties du code correspondantes *)
let main () =
	let t = Sys.argv in
	let n = Array.length t in

	if (n==1) then begin(* pas d'arguments -> lit l'entrée standard *)
		print_string "# "; flush stdout;
		let p = read_standard () in
			(try
				let res = execute p in
				print_string "- : int = ";
				print_int res;
			with | _ -> print_string "- : "; debug p);
			print_newline ()
		end
	else match t.(1) with
	| "-debug" ->  (* affiche le code *)
                  let p = read_prgm t.(n-1) in
				  debug p; print_newline ();
                  print_string "result = "; print_int (execute p);
                  print_newline ()

	| "-machine" -> (* compile et execute sur machine à pile *)
					let p = read_prgm t.(n-1) in
					StackMachine.init_and_compute p

	| "-interm" ->  (* compile vers machine à pile mais n'execute pas : affiche le code *)
					let p = read_prgm t.(n-1) in
					StackMachine.init_and_display p

	| "-NbE" -> print_string "Not implemented yet. Sorry." ; print_newline ()

	| "E" -> print_string "Not implemented yet. Sorry." ; print_newline ()

	| "R" -> print_string "Not implemented yet. Sorry." ; print_newline ()

	| "ER" -> print_string "Not implemented yet. Sorry." ; print_newline ()

	| _ ->  (* interpréteur simple*)
			let p = read_prgm t.(n-1) in
					print_int (execute p); print_newline ()


let _ = main ();;
