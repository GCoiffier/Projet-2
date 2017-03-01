{
  open Parser;;        (* le type "token" est d�fini dans parser.mli *)
(* ce n'est pas � vous d'�crire ce fichier, il est engendr� automatiquement *)
exception Eof;;
}

rule token = parse    (* la "fonction" aussi s'appelle token .. *)
  | [' ' '\t']     { token lexbuf }    (* on saute les blancs et les tabulations *)
 	     	   	           (* token: appel r�cursif *)
                                   (* lexbuf: argument implicite
                                      associ� au tampon o� sont
                                      lus les caract�res *)
  | '\n'            { EOL }
  | "/\\"           { AND }
  | "\\/"           { OR }
  | '('             { LPAREN }
  | ')'             { RPAREN }
  | '~'             { NEG }
  | 'X'             { XOR }
  | "=>"            { IMP }
  | "<=>"           { EQ }
  | ['1'-'9']+ as s { INT (int_of_string s) }
  | '-'             { MINUS }
  | '0'		    { FIN }
  | eof             { raise Eof }
