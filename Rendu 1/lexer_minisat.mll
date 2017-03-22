{
  open Parser_minisat;;        (* le type "token" est d�fini dans parser.mli *)
(* ce n'est pas � vous d'�crire ce fichier, il est engendr� automatiquement *)
exception Eof;;
}

rule token = parse    (* la "fonction" aussi s'appelle token .. *)
  | [' ' '\t' '\n']     { token lexbuf }    (* on saute les blancs et les tabulations *)
 	     	   	           (* token: appel r�cursif *)
                                   (* lexbuf: argument implicite
                                      associ� au tampon o� sont
                                      lus les caract�res *)

  | "SAT"           { SAT }
  | "UNSAT"	    { UNSAT }
  | '-' 	    { MINUS }
  | '0'		    { FIN }
  | ['0'-'9']+ as s { INT (int_of_string s) }
  | eof             { raise Eof }
