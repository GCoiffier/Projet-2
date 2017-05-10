open Environnement
open Fouine_type
open Machine

type ret = Env.elt * bool (* Le type de retour de l'interprétation. Le booléen indique si on a levé une exception *)
type mixed_programme = programme*bool (*  Le booléen indique la pureté du code. Il est calculé en avance *)

let return = function
      Env.Int(n) -> n
    | Env.Array(_) -> failwith "Execution Error: expected integer, got array"
    | Env.Ref(_) -> failwith "Execution Error: expected integer, got reference"
    | Env.Cloture(_,_) -> failwith "Execution Error: expected integer, got function"


let rec label_pure_code : programme -> mixed_programme = function
    Unit -> Unit,true
    | Const(n) as c -> c,true
    | Var(x) as v -> v,true
    | PrInt(p) as pr -> let v,b = label_pure_code p in pr,b
    | Let(x,val_x,p) as lt-> let vx,bx = label_pure_code val_x and vp,bp = label_pure_code p in
                                    lt, (bx&&bp)
    | UnOp(op,a) as un ->  let v,b = label_pure_code a in un,b
    | BinOp(a,op,b) as bin -> let va,ba = label_pure_code a and vb,bb = label_pure_code b in
                                    bin, (ba&&bb)
    | x -> x,false



(* ------ Execution complète (avec les extensions) ------ *)
let execute_mixte : programme -> int = fun prg ->
    let rec exec_aux env  = function

    | x,pure when pure -> Env.Int(StackMachine.init_and_compute x),false

    | LetRec(f,expr_f,p),_ ->  let copy = Env.copy env in
                            let clt = Env.Cloture(expr_f, copy) in
                            Env.add copy f clt; (* Comme la fonction s'appelle elle-même, la cloture se contient elle même*)
                            Env.add env f clt;
                            let ret,b = (exec_aux env  p) in
                            Env.remove env f; ret,b

    | IfThenElse(b,p1,p2),_ -> let x,b = (exec_aux env b) in
                             if b then x,b
                             else if ((return x)=1) then (exec_aux env p1)
                                        else (exec_aux env p2)

    (* Fonctions *)
    | Function_def(_,_) as f,_ -> Env.Cloture(f, Env.copy env),false

    | Function_call(f,arg),_ ->   let value,b = exec_aux env arg in
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
    | TryWith(p1,x,p2),_ -> let old_env = Env.copy env in
                            let v,b = (exec_aux env p1) in
                                Env.add old_env x v;
                                if b then (exec_aux old_env p2)
                                     else v,false

    | Raise(expr),_ -> (fst (exec_aux env expr)),true

    (* aspects impératifs et références *)
    | Imp(p1,p2),_ -> let u,b = exec_aux env p1 in
                        (* test pour vérifier que l'on a pas de raise dans p1, auquel cas il ne faut PAS executer p2 *)
                        if b then u,b else
                            (exec_aux env p2)

    | Ref(x),_ -> let v,b = (exec_aux env x) in
                    if b then v,b else
                        Env.Ref(ref (return v)),false

    | Bang(x),_ -> let u = (Env.find env x) in
                    (match u with
                        Env.Ref(a) -> Env.Int(!a),false
                        | _ -> failwith "Error : Not a reference"
                    )

    | Assign(x,p),_ -> let u,b = (exec_aux env p) in
                        if b then u,b else begin
                         (match (Env.find env x) with
                            Env.Ref(r) -> r := (return u)
                            | _ -> failwith "Error : Not a reference");
                        u,false end
    (* tableaux  *)
    | AMake(x),_ -> let n,b = (exec_aux env x) in
                        if b then n,b else (Env.Array (Array.make (return n) 0)),false

    | Affect(t,i,x),_ -> let ind,b = (exec_aux env i) in
                            if b then ind,b else
                        let tab = Env.find env t in
                            (match tab with
                                Env.Array(ar) -> let ret,b = exec_aux env x in
                                                    if b then ret,b else begin
                                                        ar.((return ind)) <- (return ret);
                                                        ret,false end
                                | _ -> failwith "Error with affect : not an array"
                            )

    | Access(t,i),_ -> let ind,b = (exec_aux env i) in
                    if b then ind,b else
                        let tab = Env.find env t in
                            (match tab with
                                Env.Array(ar) -> Env.Int(ar.(return ind)),false
                                | _ -> failwith "Error with access : not an array"
                            )

    in let mixed = label_pure_code prg in
     let v,b =  (exec_aux (Env.create 10) mixed) in
        if b then failwith "Error : exception not caught" else return v
