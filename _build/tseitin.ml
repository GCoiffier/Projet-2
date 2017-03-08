open Formula

(* transforme l'expression *)
let rec tseitin2 e k = let q = !k in k := (!k)+1; (* q nouveau *)
  match e with
  |Var(x) -> Var(x),Const(true)
  |Const(true) -> Var(q), Var(q)
  |Const(false) -> Var(q), NOT(Var(q))
  |XOR(e1,e2) -> tseitin2 ( OR( AND( NOT(e1), e2 ) , AND( e1, NOT(e2) ) ) ) k
  |NOT(e1) -> let l,t1 = tseitin2 e1 k in 
	      NOT(Var(q)), t1
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
				OR(
				l1,
				NOT(Var(q))), 
			AND(
				OR(
				l2,
				NOT(Var(q)))
			,
				OR(
				Var(q),
				OR(
				NOT(l1),
				NOT(l2)))
			))))
  |IMPLIES(e1,e2) -> let l1,t1 = tseitin2 e1 k in let l2,t2 = tseitin2 e2 k in
   		Var(q), AND(
			t1,
			AND(
			t2,
			AND(
				OR(
				l1,
				Var(q)),
			AND(
				OR(
				NOT(l2),
				Var(q))
			,
				OR(
				NOT(Var(q)),
				OR(
				NOT(l1),
				l2))			
			))))
  |EQUIV(e1,e2) -> let l1,t1 = tseitin2 e1 k in let l2,t2 = tseitin2 e2 k in
   		Var(q), AND(
			t1,
			AND(
			t2,
			AND(
				OR(
				NOT(Var(q)),
				OR(
				NOT(l1),
				l2)),
			AND(
				OR(
				NOT(Var(q)),
				OR(
				l1,
				NOT(l2))),
			AND(
				OR(
				Var(q),
				OR(
				l1,
				l2))
			,
				OR(
				Var(q),
				OR(
				NOT(l1),
				NOT(l2)))
			)))))

let tseitin e = 
	let rec maxi e = match e with
		|Var(x) -> x
		|Const(_) -> 0
		|NOT(e1) -> maxi e1
		|OR(e1,e2) -> max (maxi e1) (maxi e2)
		|AND(e1,e2) -> max (maxi e1) (maxi e2)
		|IMPLIES(e1,e2) -> max (maxi e1) (maxi e2)
		|XOR(e1,e2) -> max (maxi e1) (maxi e2)
		|EQUIV(e1,e2) -> max (maxi e1) (maxi e2)
	in
	let l,t = tseitin2 e (ref ((maxi e)+1)) in
	AND(l,t);;

(*les 2 fonctions suivantes servent a simplifier les CNF sortie de tseitin *)
let rec replace e k b = let _b = (b = false) in  (* met la variable k à b dans l'expression *)
  match e with
  |NOT(Var(q)) when q=k -> Const(_b)
  |Var(q) when q=k -> Const(b)
  |AND(e1,e2) -> AND( replace e1 k b, replace e2 k b)
  |OR(e1,e2) -> OR( replace e1 k b, replace e2 k b)
  |_ -> e

let rec del_not_not e = match e with
  |NOT(NOT(e')) -> del_not_not e'
  |AND(e1,e2) -> AND(del_not_not e1, del_not_not e2)
  |OR(e1,e2) -> OR(del_not_not e1, del_not_not e2)
  |_ -> e

exception Nbeg of formula
let rec reduction expr = (* c'est un O(n**2) avec n le nombre de termes *)
  let rec red_aux e = match e with
  |AND(Var(k),e2) -> let expr' = replace expr k true in raise (Nbeg expr') (*On reprend depuis le debut *)
  |AND(e2,Var(k)) -> let expr' = replace expr k true in raise (Nbeg expr') 
  |AND(e2,NOT(Var(k))) -> let expr' = replace expr k false in raise (Nbeg expr') 
  |AND(NOT(Var(k)),e2) -> let expr' = replace expr k false in raise (Nbeg expr') 
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
    Nbeg expr' -> reduction expr';;

let rec reduction_full expr = let expr' = reduction expr in
	if expr = expr'
	then expr
	else reduction_full expr'

(*let e = AND(Var(1),OR(NOT(Var(1)),Var(2)));;
reduction e;;
replace e 1 false;;
tseitin e;;
reduction (tseitin e);;
reduction_full (tseitin e);;*)
