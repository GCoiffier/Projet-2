open Expr

let compile e =
  begin
    affiche_expr e;
    print_newline();
    print_int (eval e);
    print_newline()
  end

(* stdin désigne l'entrée standard (le clavier) *)
(* lexbuf est un canal ouvert sur stdin *)

let lexbuf = Lexing.from_channel stdin

let parse () = Parser.main Lexer.token lexbuf

let parse2 () = Parser2.main Lexer2.token lexbuf

(* la fonction que l'on lance ci-dessous *)
let calc () =
  try
      let result = parse () in
	compile result; flush stdout
  with _ -> (print_string "erreur de saisie\n")
;;

let rec fact = function
  | 0|1 -> 1
  | n -> n*(fact (n-1))

let run_fact () =
  try
      let k = parse2 () in
      begin
	print_string (string_of_int (fact k));
	print_newline();
	flush stdout
      end
  with _ -> (print_string "erreur de saisie\n")
  


let _ =
  let s = Sys.argv.(1) in
  match s with
  | "-expr" -> calc ()
  | "-fact" -> run_fact ()
  | _ ->
    begin
      print_string "usage: ./calc -expr ou ./calc -fact";
      print_newline(); 
    end
