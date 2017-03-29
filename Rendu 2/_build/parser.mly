%{
(* --- préambule: ici du code Caml --- *)

open Fouine
open Expr_arith
open Expr_bool

%}
/* description des lex�mes, ceux-ci sont décrits dans lexer.mll */

%token <int> CONST       /* le lex�me INT a un attribut entier */
%token <string> VARIABLE
%token ADD MINUS MULT DIV MOD
%token AND OR NOT
%token EGALE NEG SUPS INFS SUPE INFE
%token IF THEN ELSE PRINT LET IN
%token FUN IMPLIES
%token LPAREN RPAREN
%token EOL EINSTR

%left ADD, MINUS
%left AND, OR
%left NOT
%left DIV, MULT, MOD

%start main
%type <Fouine.programme> main

%%
    /* --- début des règles de grammaire --- */

main:
    instr EOL               { $1 }

instr:
  | IF bexpr THEN instr ELSE instr		  { IfThenElse($2,$4,$6) }
  | PRINT aexpr					                { PrInt($2) }
  | LET VARIABLE EGALE aexpr IN instr		{ Let($2,$4,$6) }
  | LPAREN instr RPAREN 			          { $2 }
  | instr EINSTR instr				          { Imp($1,$3) } /* séquencement */

  /* | LET funct EGALE aexpr IN instr		{ Imp( Function($2,$4) ,$6) } */
  /* | LET VARIABLE EGALE FUN VARIABLE IMPLIES aexpr IN inst */
  | aexpr					{ Arith($1) }

aexpr: /* expression arithmétique */
  | LPAREN aexpr RPAREN 				{ $2 }
  | aexpr ADD aexpr				{ Plus($1,$3) }
  | aexpr MINUS aexpr				{ Minus($1,$3) }
  | aexpr MULT aexpr				{ Mult($1,$3) }
  | aexpr DIV aexpr				{ Div($1,$3) }
  | aexpr MOD aexpr				{ Mod($1,$3) }
  | VARIABLE					{ Var($1) }
  | CONST					{ Const($1) }
  /* | funct					{ EVFUN($1) } */


bexpr: /* Expression booléenne */
  | bexpr AND bexpr				  { And($1,$3) }
  | bexpr OR bexpr				  { Or($1,$3) }
  | NOT bexpr               { Not($2) }
  | aexpr EGALE aexpr				{ Comp($1, Equal ,$3) }
  | aexpr NEG aexpr				  { Comp($1, Neq ,$3) }
  | aexpr SUPS aexpr				{ Comp($1, Sup ,$3) }
  | aexpr INFS aexpr				{ Comp($1, Inf ,$3) }
  | aexpr SUPE aexpr				{ Comp($1, Supeq ,$3) }
  | aexpr INFE aexpr				{ Comp($1, Infeq ,$3) }

/* funct:
   | VARIABLE funct				{ FUN($1,$2) }
   | VARIABLE VARIABLE				{ FUN($1,$2) }*/

;
