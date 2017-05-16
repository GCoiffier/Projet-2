open Environnement
open Fouine_type
open Machine

module type InterpreteurSig = sig

    val execute : programme -> int
    (* Exécute le programme à l'aide d'un interpréteur et renvoie le résultat *)

    val execute_mixte : programme -> int
    (* Exécute le programme avec l'interpréteur en envoyant certains morceaux vers une machine à pile *)

    val debug : programme -> unit
    (* Affiche le programme *)
end

module Interpreteur:InterpreteurSig = struct

    type ret = Env.elt * bool (* Le type de retour de l'interprétation. Le booléen indique si on a levé une exception *)

    let return = function
          Env.Int(n) -> n
        | Env.Array(_) -> failwith "Execution Error: expected integer, got array"
        | Env.Ref(_) -> failwith "Execution Error: expected integer, got reference"
        | Env.Cloture(_,_) -> failwith "Execution Error: expected integer, got function"

(* ------ Fonction de debug ------ *)

    let pstr = print_string (* abréviation *)

    let rec debug : programme -> unit = fun prg ->
        (* affiche le programme parsé dans la console *)
        match prg with
        Unit -> print_string "()"
        | Const(n) -> print_int n
        | Var(x) -> pstr x
        | PrInt(a) -> pstr "prInt("; debug a ; pstr ")"
    	| PrStr(s) -> pstr "prStr \""; pstr s; pstr "\""
    	| PrNL -> pstr "PrNL"
        | IfThenElse(b,p1,p2) -> pstr "If (" ;
                                debug b ;
                                pstr ") Then (" ;
                                debug p1 ;
                                pstr ") Else (";
                                debug p2;
                                pstr ")"
        | UnOp(op,a) -> pstr (match op with Neg -> "-(" | Not -> "~(");
                       debug a;
                       pstr ")"
        | BinOp(a,op,b) -> pstr "(";
                            debug a;
                            pstr ( match op with
                                | Add -> "+"     | Minus -> "-"  | And -> "&&"
                                | Or -> "||"     | Mult -> "*"   | Div -> "/"
                                | Mod -> " mod " | Equal -> "="  | Neq -> "<>"
                                | Infeq -> "<="  | Inf -> "<"    | Supeq -> ">="
                                | Sup -> ">");
                            debug b;
                            pstr ")"
        | Let(x,p1,p2) ->  pstr "let ";
                            debug x;
                            pstr " = (";
                            debug p1;
                            pstr ") in ";
                            debug p2;
        | LetRec(x,p1,p2) -> pstr "let rec ";
                            debug x;
                            pstr " = ";
                            debug p1;
                            pstr " in ";
                            debug p2
        | Function_def(x,a) -> pstr "(";
                              pstr "fun ";
                              debug x;
                              pstr " -> ";
                              debug a;
                              pstr ")"
        | Function_call(x,a) ->  debug x;
                                pstr " ";
                                debug a
        | TryWith(p1,x,p2) -> pstr "try ";
                                pstr "(";
                                debug p1;
                                pstr ")";
                                pstr " with E ";
                                debug x;
                                pstr " -> ";
                                debug p2
        | Raise(x) -> pstr "raise E ("; debug x; pstr ")"
        | Imp(p1,p2) -> debug p1; pstr " ; "; debug p2;
        | Ref(p) -> pstr "ref "; debug p
        | Bang(x) -> pstr "!"; debug x
        | Assign(x,p) -> pstr "(" ; debug x ; pstr " := "; debug p ; pstr ")"
        | AMake(x) -> pstr "aMake (" ; debug x; pstr ")"
        | Affect(t,i,x) -> debug t; pstr ".("; debug i; pstr ") <- " ; debug x
        | Access(t,i) -> debug t; pstr ".("; debug i; pstr ")"
        | Pure(p) -> pstr "Pure("; debug p; pstr ") "

    (* ------ Fonction d'interprétation ------ *)
    let execute : programme -> int = function prg ->
        let rec exec_aux env  = function

		  Pure(Const(n)) -> Env.Int(n),false
		| Pure(Var(x))   -> (Env.find env (Var(x))),false
		| Pure(Function_def(var,expr))-> let f = Function_def(var,expr) in Env.Cloture(Pure(f), Env.copy env),false
            (* appeler la machine à pile là dessus ferai qu'elle devrait renvoyer une fonction, or elle ne peut pas *)

        | Pure(prg) ->  (* print_string "Call stack machine with code : "; print_newline (); debug (transform_env env prg) ; print_newline (); *)
        				let a = StackMachine.init_and_compute (transform_env env prg) in
                        (* print_string "Machine returns sucessfully"; print_newline (); print_newline (); *)
                        Env.Int(a),false
        (* Ces quatre cas n'arrivent que si l'on appelle l'interprétation mixte.
            Décommenter pour voir les appels à la machine *)

        | Unit -> Env.Int(0),false

        | Const(n) -> Env.Int(n),false

        | Var(x) as v -> (Env.find env v),false

        | PrInt(p) -> let ret,x = (exec_aux env p) in
                      ( match ret with
                         Env.Int(x) -> print_int x; print_newline ()
                         |_ -> failwith "Execution Error in prInt"
                      ) ; ret,x

    	| PrStr(s) -> print_string s ; Env.Int(0),false

    	| PrNL -> print_newline(); Env.Int(0),false

        | Let(x,val_x,p) ->  Env.add env x (fst (exec_aux env val_x));
                            let ret,b = (exec_aux env p) in
                            Env.remove env x; ret,b

        | LetRec(f,expr_f,p) ->  let copy = Env.copy env in
                                let clt = Env.Cloture(expr_f, copy) in
                                Env.add copy f clt; (* Comme la fonction s'appelle elle-même, la cloture se contient elle même*)
                                Env.add env f clt;
                                let ret,b = (exec_aux env  p) in
                                Env.remove env f; ret,b

        | IfThenElse(b,p1,p2) -> let x,b = (exec_aux env b) in
                                 if b then x,b
                                 else if ((return x)=1) then (exec_aux env p1)
                                            else (exec_aux env p2)

        | UnOp(op,a) ->  let v,b = (exec_aux env a) in
                        if b then v,b else
                        let x = return v in
                        ( match op with
                             Neg -> Env.Int(-x)
                           | Not -> Env.Int(1-x)
                        ),false

        | BinOp(a,op,b) -> let va,ba = (exec_aux env a) and
                              vb,bb = (exec_aux env b) in
                          if ba then va,true else
                          if bb then vb,true else
                          let xa = return va and xb = return vb in
                          let c1 = Env.Int(1) and c0 = Env.Int(0) in
                           ( match op with
                              | Add -> Env.Int(xa+xb)
                              | Minus -> Env.Int(xa - xb)
                              | And -> Env.Int(xa*xb)
                              | Or -> if ((xa+xb)>0) then c1 else c0
                              | Mult -> Env.Int(xa*xb)
                              | Div -> Env.Int(xa/xb)
                              | Mod -> Env.Int(xa mod xb)
                              | Equal -> if (xa==xb) then c1 else c0
                              | Neq -> if (xa<>xb) then c1 else c0
                              | Infeq -> if (xa<=xb) then c1 else c0
                              | Inf -> if (xa<xb) then c1 else c0
                              | Supeq -> if (xa>=xb) then c1 else c0
                              | Sup -> if (xa>xb) then c1 else c0
                           ),false

        (* Fonctions *)
        | Function_def(_,_) as f -> Env.Cloture(f, Env.copy env),false

        | Function_call(f,arg) ->   let value,b = exec_aux env arg in
                                    if b then value,b else
                                    let v,b = (exec_aux env f) in
                                    if b then v,b else
                                    (match v with
                                    | Env.Cloture(Function_def(x,expr), clt ) ->
                                        Env.add clt x value;
                                        let ret,b = exec_aux clt expr in
                                        if b then ret,b else begin
                                        Env.remove clt x; ret,false end
                                    | _ -> failwith "Error in function call"
                                    )
        (* Exceptions  *)
        | TryWith(p1,x,p2) -> let old_env = Env.copy env in
                                let v,b = (exec_aux env p1) in
                                    Env.add old_env x v;
                                    if b then (exec_aux old_env p2)
                                         else v,false

        | Raise(expr) -> (fst (exec_aux env expr)),true

        (* aspects impératifs et références *)
        | Imp(p1,p2) -> let u,b = exec_aux env p1 in
                            (* test pour vérifier que l'on a pas de raise dans p1, auquel cas il ne faut PAS executer p2 *)
                            if b then u,b else
                                (exec_aux env p2)

        | Ref(x) -> let v,b = (exec_aux env x) in
                        if b then v,b else
                            Env.Ref(ref (return v)),false

        | Bang(x) -> let u = (Env.find env x) in
                        (match u with
                            Env.Ref(a) -> Env.Int(!a),false
                            | _ -> failwith "Error : Not a reference"
                        )

        | Assign(x,p) -> let u,b = (exec_aux env p) in
                            if b then u,b else begin
                             (match (Env.find env x) with
                                Env.Ref(r) -> r := (return u)
                                | _ -> failwith "Error : Not a reference");
                            u,false end
        (* tableaux  *)
        | AMake(x) -> let n,b = (exec_aux env x) in
                            if b then n,b else (Env.Array (Array.make (return n) 0)),false

        | Affect(t,i,x) -> let ind,b = (exec_aux env i) in
                                if b then ind,b else
                            let tab = Env.find env t in
                                (match tab with
                                    Env.Array(ar) -> let ret,b = exec_aux env x in
                                                        if b then ret,b else begin
                                                            ar.((return ind)) <- (return ret);
                                                            ret,false end
                                    | _ -> failwith "Error with affect : not an array"
                                )

        | Access(t,i) -> let ind,b = (exec_aux env i) in
                        if b then ind,b else
                            let tab = Env.find env t in
                                (match tab with
                                    Env.Array(ar) -> Env.Int(ar.(return ind)),false
                                    | _ -> failwith "Error with access : not an array"
                                )

        in let v,b =  (exec_aux (Env.create 10) prg) in
            if b then failwith "Error : exception not caught" else return v

(* ------ exécution mixte interpréteur/machine à pile ------ *)

    let is_pure = function
        | Pure(_) -> true
        | _ -> false

    let label_pure_code : programme -> programme = function prg ->
        let rec lbl l = function
            Pure(_) -> failwith "Error : trying to label a code that is already labeled"
            | Unit -> Pure(Const(0))
            | Const(n) as c -> Pure(c)
            | Var(x) as v -> if (List.mem v l) then Pure(v) else v
            | PrInt(p) as prt-> let x = lbl l p in
                                if (is_pure x) then Pure(prt) else PrInt(x)

            | PrStr(s) as p -> p
            | PrNL -> PrNL
            | Let(x,val_x,p) as lt -> let rx = lbl l val_x in
                                      let px = lbl (if (is_pure rx) then (x::l) else l) p in
                                        if (is_pure rx)&&(is_pure px) then Pure(lt)
                                        else Let(x,rx,px)

            | LetRec(f,expr_f,p) as ltrec ->  let rf = lbl (f::l) expr_f in
                                                if (is_pure rf) then
                                                    let px = lbl (f::l) p in
                                                    if (is_pure px) then Pure(ltrec)
                                                    else LetRec(f,rf,px)
                                                else let rf = lbl l expr_f in
                                                    let px = lbl l p in
                                                    if (is_pure px) then Pure(ltrec)
                                                    else LetRec(f,rf,px)

            | IfThenElse(b,p1,p2) as ite -> let rb = lbl l b and
                                         rp1 = lbl l p1 and
                                         rp2 = lbl l p2 in
                                        if (is_pure rb)&&(is_pure rp1)&&(is_pure rp2) then Pure(ite)
                                        else IfThenElse(rb,rp1,rp2)


            | UnOp(op,a) as un -> let ra = lbl l a in
                                if (is_pure ra) then Pure(un) else UnOp(op,ra)

            | BinOp(a,op,b) as bin -> let ra = lbl l a and rb = lbl l b in
                                        if (is_pure ra)&&(is_pure rb) then Pure(bin)
                                        else BinOp(ra,op,rb)
            (* Fonctions *)
            | Function_def(var,expr) as f-> let r = lbl (var::l) expr in
                                                if (is_pure r) then Pure(f) else
                                                Function_def(var,r)

            | Function_call(f,arg) as call-> let r = lbl l arg in
                                                let rf = lbl l f in
                                                if (is_pure r)&&((is_pure rf)||(List.mem f l)) then Pure(call) else
                                                Function_call(f,r)

            (* Exceptions  *)
            | TryWith(p1,x,p2) -> TryWith(lbl l p1, lbl l x, lbl (x::l) p2)

            | Raise(expr) -> Raise(lbl l expr)

            (* aspects impératifs et références *)
            | Imp(p1,p2) as imp -> let ra = lbl l p1 in let rb = lbl l p2 in
            				if (is_pure ra)&&(is_pure rb)
            				then Pure(imp)
            				else Imp(ra,rb)
            | Ref(x) -> Ref(lbl l x)
            | Bang(x) -> Bang(lbl l x)
            | Assign(x,p) -> Assign(lbl l x, lbl l p)

            (* tableaux  *)
            | AMake(x) -> AMake(lbl l x)
            | Affect(t,i,x) -> Affect( lbl l t, lbl l i, lbl l x)
            | Access(t,i) -> Access(lbl l t, lbl l i)
        in lbl [] prg

    let execute_mixte = function
        prg -> (* debug (label_pure_code prg); print_newline (); *)
                execute (label_pure_code prg)

end
