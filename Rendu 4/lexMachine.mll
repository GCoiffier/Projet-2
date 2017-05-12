{
  open ParsMachine;;        (* le type "token" est d�fini dans parser.mli *)
(* ce n'est pas � vous d'�crire ce fichier, il est engendr� automatiquement *)
exception Eof;;
}

rule token = parse    (* la "fonction" aussi s'appelle token .. *)
	| [' ' '\t' '\n']   { token lexbuf }

	| ['0'-'9']+ as s       { INT (int_of_string s) }
	| "ADD"				    { ADD }
	| "MINUS"				{ MINUS }
	| "MULT"				{ MULT }
	| "DIV"				    { DIV }
	| "MOD"				    { MOD }
	| "UMINUS"				{ UMINUS }
	| "PRINT"				{ PRINT }
	| "POP"					{ POP }

	| "IF"					{ IF }
	| "IFEND"				{ IFEND }
	| "ELSE"				{ ELSE }

	| "AND"				    { AND }
	| "OR"					{ OR }
	| "EQUAL"				{ EQUAL }
	| "NEQUAL"				{ NEQUAL }
	| "INFEQ"				{ INFEQ }
	| "INF"				    { INF }
	| "SUPEQ"				{ SUPEQ }
	| "SUP"				    { SUP }


	| "LET"				    { LET }
	| "ACCESS"			    { ACCESS }
	| "ENDLET"			    { ENDLET }
	
	| "FUNCT"				{ FUNCT }
	| "RETURN"				{ RETURN }
	| "CALL"				{ CALL }
	| "LETREC"				{ LETREC } 
	| ";;"				    { EOL }
