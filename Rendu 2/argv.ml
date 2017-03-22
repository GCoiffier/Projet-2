open Fouine

(* argv_call : unit -> unit
	Fonction principale : lit les arguments donnés au programme et appelle les parties du code correspondantes *)
let argv_call () =
	let t = Sys.argv in
	let n = (Array.length t) in
	let entree = t.(n-1) in
	match t.(1) with
	|"-debug" ->  ()
	|"-machine" -> ()
	|"-interm" -> ()
	|_ -> ()
