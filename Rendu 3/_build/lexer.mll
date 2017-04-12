{
  open Parser;;        (* le type "token" est d�fini dans parser.mli *)
(* ce n'est pas � vous d'�crire ce fichier, il est engendr� automatiquement *)
exception Eof;;
}

rule token = parse    (* la "fonction" aussi s'appelle token .. *)
	| [' ' '\t' '\n']     		{ token lexbuf }

	| "prInt"			{ PRINT }
	| "prStr \"" ([' '-'!' '#'-'}']+ as s) "\""      
	                    { PRSTR(s) }
	| "prNl"            { PRNL }

	| "let"		 		{ LET }
	| "rec"             { REC }
	| "in"		 		{ IN }
	| "if" 				{ IF }
	| "then" 			{ THEN }
	| "else" 			{ ELSE }
    | "begin"           { BEGIN }
    | "end"             { END }

	| "raise"           { RAISE }
	| "try"             { TRY }
	| "with"            { WITH }
	| "E"               { EXCEPT }

	| "ref"             { REF }
	| ":="              { AFFECT }
	| "!"               { ACCESS }
    | '_'               { UNDERSCORE }
    
    | "aMake"           { AMAKE }
    | "<-"              { LARROW }
    | (['a'-'z' 'A'-'Z']+ as s) ".("
                        { TAFFECT(s) }

	| '+' 				{ ADD }
	| '-' 				{ MINUS }
	| '*'				{ MULT }
	| '/' 				{ DIV }
	| "mod" 			{ MOD }

	| "fun"				{ FUN }
	| "->"				{ IMPLIES }

	| '=' 				{ EGALE }
	| "<>"				{ NEG }
	| '>' 				{ SUPS }
	| '<' 				{ INFS }
	| ">=" 				{ SUPE }
	| "<=" 				{ INFE }

	| "&&" 				{ AND }
	| "||" 				{ OR }
	| "not" 			{ NOT }

    | "()"              { UNIT }
    | '('               { LPAREN }
    | ')'               { RPAREN }

	| ['0'-'9']+ as s 		        { CONST (int_of_string s) }
	| ['a'-'z' 'A'-'Z']+ as s 		{ VARIABLE (s) }

	| ";;"				{ EOL }
    | ';' 				{ EINSTR }
