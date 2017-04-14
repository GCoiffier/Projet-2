open Fouine_type

let rec translate : programme -> programme
    = function
    Unit -> Unit
    | Const(i) as p -> p
    | Var(x) as p -> p
    | PrInt(x) as p -> p
    | UnOp(op,x) as p -> p
    | BinOp(a,op,b) as p -> p
    | Let(x,a,b) as p -> p
    | LetRec(x,a,b) as -> p
    | Function_def(x,a) as p -> p
    | Function_cal(x,a) as p -> p
    | IfThenElse(b,p1,p2) as p -> p
    | TryWith -> failwith "not implemented yet"
    | Raise -> failwith "not implemented yet"
    | Imp -> failwith "not implemented yet"
    | Ref -> failwith "not implemented yet"
    | Bang -> failwith "not implemented yet"
    | Assign -> failwith "not implemented yet"
    | AMake -> failwith "not implemented yet"
    | Affect -> failwith "not implemented yet"
    | Access -> failwith "not implemented yet"
