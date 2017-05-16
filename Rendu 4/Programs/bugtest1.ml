let y= ref 2 in

let f x =
let y =ref 3 in raise (E 2) in
try f 1 with
 E x -> prInt !y;

let f x =
y:=4 ; raise (E 2) in
try f 1 with
 E x -> prInt !y;

 try y:=5 ; raise (E 2) with
 E x -> prInt !y;

 try let y=ref 6 in raise (E 2) with
 E x -> prInt !y
 ;;
