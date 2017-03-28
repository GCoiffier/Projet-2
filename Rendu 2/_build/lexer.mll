{
  open Parser;;        (* le type "token" est d�fini dans parser.mli *)
(* ce n'est pas � vous d'�crire ce fichier, il est engendr� automatiquement *)
exception Eof;;
}

rule token = parse    (* la "fonction" aussi s'appelle token .. *)
	| [' ' '\t' '\n']     		{ token lexbuf }

	| "prInt"			{ PRINT }

	| "let"		 		{ LET }
	| "in"		 		{ IN }
	| "if" 				{ IF }
	| "then" 			{ THEN }
	| "else" 			{ ELSE }
	| ";" 				{ EINSTR }

	| '+' 				{ ADD }
	| '-' 				{ MINUS }
	| '*'				  { MULT }
	| '/' 				{ DIV }
	| '%' 				{ MOD }

	| '=' 				{ EQ }
	| "<>"				{ NEQ }
	| '>' 				{ SUP }
	| '<' 				{ INF }
	| ">=" 				{ SUPEQ }
	| "<=" 				{ INFEQ }

	| "&&" 				{ AND }
	| "||" 				{ OR }
  | "not"       { NOT }
  
	| ['0'-'9'] + as s 		{ INT (int_of_string s) }
	| ['a'-'Z'] + as s 		{ VARIABLE (s) }

	| ";;"				{ EOL }
