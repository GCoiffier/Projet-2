open Formula
open Bdd.BDD
open LexParInterface
open Minisat
open Tseitin

let do_BDD entree = 3

let do_tseitin entree sortie = 
	let tsei = reduction_full( tseitin entree) in
	if (sortie != "")
	then (print_for_minisat tsei (* sortie *); )
	else ();
	tsei	
	
let do_minisat entree sortie = 
	let tsei = do_tseitin entree sortie in
	print_for_minisat tsei (* "_build/m.cnf" *);
	Sys.command("minisat _build/m.cnf _build/output.txt > _build/stuff.txt")
	(*lire la sortie de minisat et faire la comparaison BDD *)
	
let truc () = let t = Sys.argv in let n = (Array.length t) in let entree = t.(n-1) in
	let a = read_formula entree in
	match t.(1) with
	|"-minisat" ->  if(t.(2) = "-tseitin") 
			then do_minisat a (t.(n-2)) 
			else do_minisat a ""
	|"-tseitin" -> do_tseitin a (t.(n-2))
	|_ -> do_BDD entree
	

