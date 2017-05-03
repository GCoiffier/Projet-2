%{

open Machine

%}

/* description des lexèmes, ceux-ci sont décrits dans lexer.mll */
%token <int> INT
%token <string> LET
%token <string> ACCESS
%token ENDLET
%token ADD MINUS MULT DIV MOD UMINUS PRINT
%token AND OR
%token EQUAL NEQUAL SUP SUPEQ INFEQ SUP INF
%token IF ELSE IFEND
%token EOL

%start main
%type <Machine.instruction list> main

%%
    /* --- début des règles de grammaire --- */

main:
  | instrl EOL                                      { $1 }

instrl:
	instr											{ [$1] }
	|instr instrl									{ $1::$2 }
;

instr:
  	| IF instrl ELSE instrl IFEND					{ IF($2,$4) }
  	| INT											{ INT($1) }
  	
  	| ADD											{ ADD }
	| MINUS											{ MINUS }
	| MULT											{ MULT }
	| DIV											{ DIV }
	| MOD											{ MOD }
	| UMINUS										{ UMINUS }
	| PRINT											{ PRINT }
	
	| AND											{ AND }
	| OR											{ OR }
	| EQUAL											{ EQUAL }
	| NEQUAL										{ NEQUAL }
	| INFEQ											{ INFEQ }
	| INF											{ INF }
	| SUPEQ											{ SUPEQ }
	| SUP											{ SUP }
	
	| LET											{ LET($1) }
	| ACCESS										{ ACCESS($1) }
	| ENDLET										{ ENDLET }
;

