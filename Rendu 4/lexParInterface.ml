(* stdin désigne l'entrée standard (le clavier) *)
(* lexbuf est un canal ouvert sur stdin *)
open Interpreteur
open Machine

let lexbuf fd = Lexing.from_channel fd

(* on enchaîne les tuyaux: lexbuf est passé à Lexer.token,
   et le résultat est donné à Parser.main *)

let parse entree = Parser.main Lexer.token (lexbuf entree)

(* la fonction que l'on lance ci-dessous *)
let read_prgm entree =
	let fd = open_in entree in
    let a = parse fd in
      close_in fd; a

let read_standard () =
	(* lit l'entrée standard *)
	let fd = stdin in
	let a = parse fd in
	  close_in fd; a
	 
	 
	 
	 
	 
	 

(* on enchaîne les tuyaux: lexbuf est passé à Lexer.token,
   et le résultat est donné à Parser.main *)

let parse_mach entree = ParsMachine.main LexMachine.token (lexbuf entree)

(* la fonction que l'on lance ci-dessous *)
let read_mach entree =
	let fd = open_in entree in
    let a = parse_mach fd in
      close_in fd; a
