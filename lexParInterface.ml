(* stdin désigne l'entrée standard (le clavier) *)
(* lexbuf est un canal ouvert sur stdin *)
open Formula

let lexbuf = Lexing.from_channel stdin

(* on enchaîne les tuyaux: lexbuf est passé à Lexer.token,
   et le résultat est donné à Parser.main *)

let parse () = Parser.main Lexer.token lexbuf

(* la fonction que l'on lance ci-dessous *)
let read_formula () =
  try
<<<<<<< HEAD:API.ml
      parse () 
  with _ -> (failwith "erreur de saisie\n")

=======
      parse ()
  with _ -> failwith "erreur de saisie"
>>>>>>> master:lexParInterface.ml
