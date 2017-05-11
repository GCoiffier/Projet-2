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

    (* ------ Fonction d'interprétation ------ *)
    let execute : programme -> int = fun prg ->
        let rec exec_aux env  = function

        | Pure(prg) -> Env.Int(StackMachine.init_and_compute prg),false
        (* N'arrive que si l'on appelle l'interprétation mixte*)

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

            let pstr = print_string (* abréviation *)

(* ------ Fonction de debug ------ *)
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
        | Pure(_) -> () (* Ne devrait pas arriver *)


    (* ------ exécution mixte interpréteur/machine à pile ------ *)
    let rec label_pure_code : programme -> programme = function prg -> prg
        (* Unit -> Pure(Const(0))
        | Const(n) as c -> Pure(c)

        | Var(x) as v -> Pure(v)

        | PrInt(p) as prt-> let x = label_pure_code p in
                            (match x with
                            | Pure(_) -> Pure(prt)
                            | _ -> PrInt(x))

        | PrStr(s) as p -> Pure(p)

        | PrNL -> Pure(PrNL)

        | Let(x,val_x,p) as lt -> let rx = label_pure_code val_x and px = label_pure_code p in
                                    let resx = (match rx with Pure(_) as a -> a | _ -> resx Pure(lt)

        | LetRec(f,expr_f,p) as ltrec ->  Pure(ltrec)

        | IfThenElse(b,p1,p2) -> Pure()

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
        | TryWith(p1,x,p2) -> TryWith(label_pure_code p1, label_pure_code x, label_pure_code p2)

        | Raise(expr) -> Raise(label_pure_code expr)

        (* aspects impératifs et références *)
        | Imp(p1,p2) -> Imp(label_pure_code p1, label_pure_code p2)
        | Ref(x) -> Ref(label_pure_code x)
        | Bang(x) -> Bang(label_pure_code x)
        | Assign(x,p) -> Assign(label_pure_code x, label_pure_code p)

        (* tableaux  *)
        | AMake(x) -> AMake(label_pure_code x)
        | Affect(t,i,x) -> Affect( label_pure_code t, label_pure_code i, label_pure_code x)
        | Access(t,i) -> Acces(label_pure_code t, label_pure_code i) *)


    let execute_mixte = function
        prg -> execute (label_pure_code prg);;

end
