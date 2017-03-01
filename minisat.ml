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




let minisat expr =
	print_string "p cnf ";
	print_int nb_Var expr;
	print_int nb_Clause expr;
	
