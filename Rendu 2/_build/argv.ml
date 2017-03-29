open Fouine

(* argv_call : unit -> unit
	Fonction principale : lit les arguments donnés au programme et appelle les parties du code correspondantes *)
let argv_call () =
	let t = Sys.argv in
	match t.(1) with
	|"-debug" ->  () (* affiche le code *)
	|"-machine" -> () (* compile et execute sur machine à pile *)
	|"-interm" -> ()  (* compile vers machine à pile mais n'execute pas : affiche le code *)
	|_ -> () (* interpréteur *)
