open Formula
open Bdd.BDD
open LexParInterface
open Minisat
open Tseitin
open Valuation

let do_BDD entree = let bdd = create entree in
	print_string "Taille du BDD construit : "; print_int (size bdd); print_newline ()

let do_display_BDD entree = let bdd = create entree in
	print bdd "display"

let do_tseitin (entree : formula) sortie =
	let tsei = reduction_full( tseitin entree) in
	if (sortie <> "")
	then (print_for_minisat tsei sortie ;)
	else ();
	tsei

let do_minisat entree sortie =
	let tsei = do_tseitin entree sortie in
	print_for_minisat tsei "_build/m.cnf";
	let _ = Sys.command("minisat _build/m.cnf Outputs/output.txt > _build/stuff.txt") in

	let sat, valuation = read_minisat "Outputs/output.txt" in
	let bdd = create entree in

	if sat
	then (
		if (satisfy bdd (valuation_from_list valuation))
		then print_string "minisat & tseitin agree with the bdd"
		else print_string "Error : minisat and BDD disagree";
		print_newline ();

	)
	else (
		if false
		then print_string "minisat & tseitin agree with the bdd"
		else print_string "Error : minisat and BDD disagree";
		print_newline ();
	)

let argv_call () =
	let t = Sys.argv in
	let n = (Array.length t) in let entree = t.(n-1) in
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
	|"-tseitin" -> if(n=4)
		       then let _ = do_tseitin a (t.(n-2)) in ()
		       else failwith "invalid argument"
	|"-display" -> do_display_BDD a

	|_ -> if n=2
	      then do_BDD a
	      else failwith "invalid argument"
