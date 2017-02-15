open Formula

let rec tseitin e = match e with
  |Var(x) -> x,Const(true)
  |Const(true) -> Var(q), Var(q) (* q nouveau *)
  |Const(false) -> Var(q), Not(Var(q))
  |Not(e1) -> let l,t1 = tseitin e1 in 
	      Not(Var(q)), t1
