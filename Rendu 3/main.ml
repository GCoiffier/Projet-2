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
	let p =  if (n=1 || (String.get t.(n-1) 0) = '-') (* pas d'arguments -> lit l'entrée standard *)
				then begin
					print_string "# ";
					flush stdout;
					read_standard () end
			  	else (* On lit l'argument donné *)
					read_prgm t.(n-1)
	in let opt = if n=1 then "None" else t.(1)
	in match opt with
	| "-debug" ->  (* affiche le code *)
				  debug p; print_newline ();
				  let res = execute p in
	  				print_string "- : int = ";
	  				print_int res;
	  				print_newline ()

	| "-machine" -> (* compile et execute sur machine à pile *)
					StackMachine.init_and_compute p

	| "-interm" ->  (* compile vers machine à pile et enregistre le code dans un fichier. Si pas de fichier -> sortie standard *)
					let s = StackMachine.init_and_display p in
					if n<=3 (* pas de fichiers *) then
						begin print_string s;
							  print_newline () end
					else let file = open_out ("Stack_programs/"^(t.(2))) in
						begin output_string file s;
						      close_out file end

	| "-NbE" -> print_string "Not implemented yet. Sorry." ; print_newline ()
	| "-E" -> print_string "Not implemented yet. Sorry." ; print_newline ()
	| "-R" -> print_string "Not implemented yet. Sorry." ; print_newline ()
	| "-ER" -> print_string "Not implemented yet. Sorry." ; print_newline ()

	| _ ->  (* interpréteur simple*)
				let res = execute p in
				print_string "- : int = ";
				print_int res;
				print_newline ()


let _ = main ();;
