open Environnement
open Fouine_type
open Machine

type ret = Env.elt * bool (* Le type de retour de l'interprétation. Le booléen indique si on a levé une exception *)

let return = function
      Env.Int(n) -> n
    | Env.Array(_) -> failwith "Execution Error: expected integer, got array"
    | Env.Ref(_) -> failwith "Execution Error: expected integer, got reference"
    | Env.Cloture(_,_) -> failwith "Execution Error: expected integer, got function"


let rec label_pure_code : programme -> mixed_programme = function
    Unit -> Pure(Const(0))
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
    | Access(t,i) -> Acces(label_pure_code t, label_pure_code i)



(* ------ Execution complète (avec les extensions) ------ *)
let execute_mixte : programme -> int = fun prg ->
    let rec exec_aux env  = function
    Unit -> Env.Int(0),false

    | Const(n,pure) -> Env.Int(n),false

    | Var(x,pure) ->

    | PrInt(x,pure) -> let ret,exc = if pure then (StackMachine.init_and_compute x),false
                                    else (exec_aux env p)
                    in(match ret with
                       Env.Int(x) -> print_int x; print_newline ()
                       |_ -> failwith "Execution Error in prInt"
                    ) ; ret,exc

    | PrStr(x,pure) -> print_string s ; Env.Int(0),false

	| PrNL -> print_newline(); Env.Int(0),false

    | UnOp(op,a,pure) ->  let v,b =  if pure then (StackMachine.init_and_compute a),false
                                             else (exec_aux env a) in
                    if b then v,b else
                    let x = return v in
                    ( match op with
                         Neg -> Env.Int(-x)
                       | Not -> Env.Int(1-x)
                    ),false

    | BinOp of mixed_programme * binary_op * mixed_programme * bool
    | Let of mixed_programme  * mixed_programme * mixed_programme * bool (* let x = A in B  : (x,A,B) *)
    | LetRec of mixed_programme * mixed_programme * mixed_programme * bool
    | Function_def of mixed_programme * mixed_programme * bool  (* fun x -> A  :  (x,A) *)
    | Function_call of mixed_programme * mixed_programme * bool (* f A : (f,A) *)
    | IfThenElse of mixed_programme * mixed_programme * mixed_programme * bool (* if x then A else B : (x,A,B) *)
    | TryWith of mixed_programme * mixed_programme * mixed_programme * bool (* try A with E x -> B : (A,x,B) *)
    | Raise of mixed_programme * bool
    | Imp of mixed_programme * mixed_programme * bool (* A;B *)
    | Ref of mixed_programme * bool (* ref A *)
    | Bang of mixed_programme * bool  (* !x *)
    | Assign of mixed_programme * mixed_programme * bool (* x := A *)
    | AMake of mixed_programme * bool
    | Affect of mixed_programme * mixed_programme * mixed_programme * bool (* t.(i) <- x : (t,i,x) *)
    | Access of mixed_programme * mixed_programme * bool (* t.(i)  : (t,i) *)


    in let mixed = label_pure_code prg in
     let v,b =  (exec_aux (Env.create 10) mixed) in
        if b then failwith "Error : exception not caught" else return v
