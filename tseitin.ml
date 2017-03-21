open Formula

(* transforme l'expression *)
let rec tseitin2 e k =
    let q = !k in incr k; (* q nouvelle variable *)
  match e with
  |Var(x) -> Var(x),Const(true)
  |Const(true) -> Var(q), Var(q)
  |Const(false) -> Var(q), NOT(Var(q))
  |XOR(e1,e2) -> tseitin2 ( OR( AND( NOT(e1) , e2 ) , AND( e1, NOT(e2) ) ) ) k
  |IMPLIES(e1,e2) -> tseitin2 ( OR ( NOT(e1) , e2) ) k
  |EQUIV(e1,e2) -> tseitin2 ( OR ( AND(e1,e2) , AND(NOT(e1), NOT(e2)) ) ) k
  |NOT(e1) -> let l,t1 = tseitin2 e1 k in NOT(l), t1
  |OR(e1,e2) -> let l1,t1 = tseitin2 e1 k in let l2,t2 = tseitin2 e2 k in
		Var(q), AND(
			t1,
			AND(
			t2,
			AND(
				OR(
				NOT(l1),
				Var(q)),
			AND(
				OR(
				NOT(l2),
				Var(q))
			,
				OR(
				NOT(Var(q)),
				OR(
				l1,
				l2))
			))))
  |AND(e1,e2) -> let l1,t1 = tseitin2 e1 k in let l2,t2 = tseitin2 e2 k in
		Var(q), AND(
			t1,
  		AND(
  		t2,
    	AND(
    	OR(l1 , NOT(Var(q))),
    	AND(
    	OR(l2,NOT(Var(q)))
    	,
    	OR(
    	Var(q)
      ,
    	OR( NOT(l1), NOT(l2)))
    	))))

let tseitin e =
	let l,t = tseitin2 e (ref ((max_var e)+1)) in
	AND(l,t);;

(*les 2 fonctions suivantes servent a simplifier les CNF sortie de tseitin *)
let rec replace e k b = let nonb = (b = false) in  (* met la variable k à b dans l'expression *)
  match e with
  |NOT(Var(q)) when q=k -> Const(nonb)
  |Var(q) when q=k -> Const(b)
  |AND(e1,e2) -> AND( replace e1 k b, replace e2 k b)
  |OR(e1,e2) -> OR( replace e1 k b, replace e2 k b)
  |_ -> e

let rec del_not_not e = match e with
  |NOT(NOT(ep)) -> del_not_not ep
  |AND(e1,e2) -> AND(del_not_not e1, del_not_not e2)
  |OR(e1,e2) -> OR(del_not_not e1, del_not_not e2)
  |_ -> e

exception Nbeg of formula
let rec reduction expr = (* c'est un O(n**2) avec n le nombre de termes *)
  let rec red_aux e = match e with
  |AND(Var(k),e2) -> let exprp = replace expr k true in raise (Nbeg exprp) (*On reprend depuis le debut *)
  |AND(e2,Var(k)) -> let exprp = replace expr k true in raise (Nbeg exprp)
  |AND(e2,NOT(Var(k))) -> let exprp = replace expr k false in raise (Nbeg exprp)
  |AND(NOT(Var(k)),e2) -> let exprp = replace expr k false in raise (Nbeg exprp)
  |AND(e1,e2) -> let red_e1 = red_aux e1 in let red_e2 = red_aux e2 in
		 (match red_e1,red_e2 with
		 |Const(true), _ -> red_e2
		 |_, Const(true) -> red_e1
		 |Const(false), _ -> Const(false)
		 |_, Const(false) -> Const(false)
		 |_,_ -> AND(red_e1,red_e2) )
  |OR(e1,e2) -> let red_e1 = red_aux e1 in let red_e2 = red_aux e2 in
		 (match red_e1,red_e2 with
		 |Const(false), _ -> red_e2
		 |_, Const(false) -> red_e1
		 |Const(true), _ -> Const(true)
		 |_, Const(true) -> Const(true)
		 |_,_ -> OR(red_e1,red_e2) )
  |_ -> e in
  try
    red_aux (del_not_not expr)
  with
    Nbeg exprp -> reduction exprp;;

let rec reduction_full expr = let expr' = reduction expr in
	if expr = expr'
	then expr
	else reduction_full expr'
