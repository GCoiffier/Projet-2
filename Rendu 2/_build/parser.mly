%{
(* --- pr�ambule: ici du code Caml --- *)

open Fouine

%}
/* description des lex�mes, ceux-ci sont d�crits (par vous) dans lexer.mll */

%token <int> CONST       /* le lex�me INT a un attribut entier */
%token <string> VARIABLE
%token ADD MINUS MULT DIV MOD
%token AND OR NOT
%token EQ NEQ SUP INF SUPEQ INFEQ
%token IF THEN ELSE PRINT LET IN
%token LPAREN RPAREN
%token EOL EINSTR


%start main             /* "start" signale le point d'entr�e: */
                        /* c'est ici main, qui est d�fini plus bas */
%type <Fouine.programme> main     /* on _doit_ donner le type associ� au point d'entr�e */

%%
    /* --- début des règles de grammaire --- */
                            /* droite, les valeurs associées */


main:                       /* <- le point d'entrée (cf. + haut, "start") */
    instr EOL                { $1 }  /* on veut reconnaître un "expr" */
;
instr:			    /* règles de grammaire pour les expressions */
  | IF expr THEN instr ELSE instr		{ IfThenElse($2,$4,$6) }
  | PRINT expr					{ }
  | LET VARIABLE EQ expr IN instr		{ Imp( Let($2,$4) ,$6) }
  | LPAREN instr RPAREN 			{ $2 }
  | instr EINSTR instr				{ Imp($1,$3) }

  | LET funct EQ expr IN instr		{ Imp( Function($2,$4) ,$6) }
  | expr					{ $1 }

expr: /* relation entre entier qui renvoie un entier (0 est faux et autre chose vrai pour les bool) */
  | LPAREN expr RPAREN 				{ $2 }
  | expr ADD expr				{ Plus($1,$3) }
  | expr MINUS expr			{ Minus($1,$3) }
  | expr MULT expr			{ Mult($1,$3) }
  | expr DIV expr			  { Div($1,$3) }
  | expr MOD expr				{ Mod($1,$3) }

  | expr AND expr				{ And($1,$3) }
  | expr OR expr				{ Or($1,$3) }
  | NOT expr            { Not($2) }
  | expr EQ expr				  { Comp($1, Equal ,$3) }
  | expr NEQ expr				  { Comp($1, Neq ,$3) }
  | expr SUP expr				  { Comp($1, Sup ,$3) }
  | expr INF expr				  { Comp($1, Inf ,$3) }
  | expr SUPEQ expr			  { Comp($1, Supeq ,$3) }
  | expr INFEQ expr			  { Comp($1, Infeq ,$3) }
  | VARIABLE					{ Const($1) }

  | funct					{ EVFUN($1) }

funct:
  | VARIABLE funct				{ FUN($1,$2) }
  | VARIABLE VARIABLE				{ FUN($1,$2) }
;
