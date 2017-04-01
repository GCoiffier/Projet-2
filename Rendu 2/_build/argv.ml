open Fouine
open LexParInterface

(* argv_call : unit -> unit
	Fonction principale : lit les arguments donnés au programme et appelle les parties du code correspondantes *)
let argv_call () =
	let t = Sys.argv in
	let n = Array.length t in
	try
		match t.(1) with
		|"-debug" ->  let p = read_prgm t.(n-1) in
										debug p; print_int (execute p); print_newline () (* affiche le code *)
		|"-machine" -> () (* compile et execute sur machine à pile *)
		|"-interm" -> ()  (* compile vers machine à pile mais n'execute pas : affiche le code *)
		|_ ->  (* interpréteur *)
						let p = read_prgm t.(n-1) in
								print_int (execute p); print_newline ()
	with
		_ -> failwith "Please specify a file"
