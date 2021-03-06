(* stdin désigne l'entrée standard (le clavier) *)
(* lexbuf est un canal ouvert sur stdin *)
open Formula

let lexbuf fd = Lexing.from_channel fd
	

(* on enchaîne les tuyaux: lexbuf est passé à Lexer.token,
   et le résultat est donné à Parser.main *)

let parse entree = Parser.main Lexer.token (lexbuf entree)

(* la fonction que l'on lance ci-dessous *)
let read_formula entree = let fd = open_in entree in
  try
      let a = parse fd in
      close_in fd;
      a
  with _ -> failwith "erreur de saisie"
  
let read_minisat entree = let fd = open_in entree in
  try
  	let a = Parser_minisat.main Lexer_minisat.token (lexbuf fd) in
  	close_in fd;
  	a
  with _ -> failwith "erreur de lecture"
