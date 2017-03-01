open Formula

let max_var f =
  (* count the number of variables of f. Variables should be 1 to n. *)
  let rec nb_var_aux m f = match f with
     Const(k) -> m
    |Var(x) -> if x>m then x else m
    |OR(f1,f2) -> max (nb_var_aux m f1) (nb_var_aux m f2)
    |AND(f1,f2) -> max (nb_var_aux m f1) (nb_var_aux m f2)
    |XOR(f1,f2) -> max (nb_var_aux m f1) (nb_var_aux m f2)
    |NOT(f)-> nb_var_aux m f
    |IMPLIES(f1,f2) -> max (nb_var_aux m f1) (nb_var_aux m f2)
    |EQUIV(f1,f2) -> max (nb_var_aux m f1) (nb_var_aux m f2)
  in nb_var_aux 0 f;;
  
let nb_clause expr = 
	let aux expr = match expr with
	|AND(e1,e2) -> 1 + aux e1 + aux e2
	|_ -> 0 in
   1 + aux expr

let minisat expr =
	print_string "p cnf ";
	print_int (max_var expr);
	print_int (nb_Clause expr);
	print_string "\n";
	
	let rec print_clause cl = match cl with
		|OR(e1, e2) -> print_clause e1; print_clause e2
		|Var(q) -> print_int q; print_string " "
		|NOT(Var(q)) -> print_int (-q); print_string "  "
		|_ -> failwith "Not a cnf expression" in
	
	let rec print_cnf expr = match expr with
		|AND(e1, e2) -> print_cnf e1; print_cnf e2
		|_ -> print_clause expr; print_string "0\n" in
	
	print_cnf expr 
	
