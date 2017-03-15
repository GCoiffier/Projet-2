open Formula
open Bdd.BDD
open LexParInterface
open Minisat
open Tseitin

let do_BDD entree = print_string "hello world!!\n"

let do_tseitin (entree : formula) sortie =
	let tsei = reduction_full( tseitin entree) in
	if (sortie <> "")
	then (print_for_minisat tsei sortie ;)
	else ();
	tsei

let do_minisat entree sortie =
	let tsei = do_tseitin entree sortie in
	print_for_minisat tsei "_build/m.cnf";
	Sys.command("minisat _build/m.cnf _build/output.txt > _build/stuff.txt");
	()
	(*lire la sortie de minisat et faire la comparaison BDD *)

let truc () = let t = Sys.argv in let n = (Array.length t) in let entree = t.(n-1) in
	let a = read_formula entree in
	match t.(1) with
	|"-minisat" ->  if(t.(2) = "-tseitin")
			then (  if n=5
				then do_minisat a (t.(n-2))
				else failwith "invalid argument"
			     )
			else (  if n=3
				then do_minisat a ""
				else failwith "invalid argument"
			     )
	|"-tseitin" -> if(n=3)
		       then let b = do_tseitin a (t.(n-2)) in ()
		       else failwith "invalid argument"
	|_ -> if n=2
	      then do_BDD entree
	      else failwith "invalid argument"
