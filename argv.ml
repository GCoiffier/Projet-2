open Tests
open Formula
open Bdd.BDD
open LexParInterface
open Minisat
open Tseitin

let _ = let t = Sys.argv in let n = t.size() in let entree = t(n-1) in
	let a = read_formula entree in
	match argv[1] with
	|"-minisat" -> do_minisat a ""
	|"-tseitin" -> do_tseitin a (t.size(n-2))
	|_ -> 
	
	
let do_BDD entree = ()

let do_tseitin entree sortie = 
	let tsei = reduction_full( tseitin entree) in
	if (sortie != "")
	then (print_minisat tesi (* sortie *) )
	tsei	
	
let do_minisat entree= 
	(* appelle minisat *)
