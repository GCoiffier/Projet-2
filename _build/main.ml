open Formula
open Bdd.BDD

let f1 = AND( Var(1) , XOR( AND( Var(2), Var(3)), NOT(Var(0))));;

let my_bdd = build_from_formula f1;;
print my_bdd "test";;

(*
affiche f1;;


let compile e =
  begin
    affiche e;
    print_newline()
  end

(* stdin désigne l'entrée standard (le clavier) *)
(* lexbuf est un canal ouvert sur stdin *)

let lexbuf = Lexing.from_channel stdin

(* on enchaîne les tuyaux: lexbuf est passé à Lexer.token,
   et le résultat est donné à Parser.main *)

let parse () = Parser.main Lexer.token lexbuf

(* la fonction que l'on lance ci-dessous *)
let calc () =
  try
      let result = parse () in
      (* Expr.affiche_expr result; print_newline (); flush stdout *)
	compile result; flush stdout
  with _ -> (print_string "erreur de saisie\n")
;;

let _ = calc()

*)
