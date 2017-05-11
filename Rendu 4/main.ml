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
<<<<<<< HEAD
open Debug
=======
>>>>>>> mixte
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
				  Interpreteur.debug p; print_newline ();
				  let res = Interpreteur.execute p in
	  				print_string "- : int = ";
	  				print_int res;
	  				print_newline ()

	| "-machine" -> (* compile et execute sur machine à pile en utilisant un interpéteur mixte *)
					let res = Interpreteur.execute_mixte p in
						print_string "- : int = ";
						print_int res;
						print_newline ()

	| "-interm" ->  (* compile vers machine à pile et enregistre le code dans un fichier. Si pas de fichier -> sortie standard *)
					let s = (StackMachine.init_and_display p) in
					if n<=3 then
						(* pas de fichiers *)
						begin print_string s;
							  print_newline () end
					else let file = open_out t.(2) in
						begin output_string file s;
						      close_out file end

	| "-execute" -> (* lit un fichier préalablement compilé et l'execute sur une machine à pile*)
					let prg = read_mach t.(2) in
					let ret = StackMachine.compute prg in
					print_string "- Result = "; print_int ret; print_newline ()

	| _ ->  (* interpréteur simple*)
				let res = Interpreteur.execute p in
				print_string "- : int = ";
				print_int res;
				print_newline ()

let _ = main ();;
