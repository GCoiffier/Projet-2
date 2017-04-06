%{

open Interpreteur
open Prog_type

%}
/* description des lexèmes, ceux-ci sont décrits dans lexer.mll */

%token <int> CONST
%token <string> VARIABLE
%token ADD MINUS MULT DIV MOD
%token AND OR NOT
%token EGALE NEG SUPS INFS SUPE INFE
%token IF THEN ELSE PRINT LET IN
%token FUN IMPLIES REC
%token LPAREN RPAREN UNIT
%token EOL EINSTR
%token TRY WITH EXCEPT RAISE
%token REF AFFECT ACCESS

%left LET, IN
%left EINSTR
%left IF, THEN, ELSE
%left PRINT
%right FUN, IMPLIES
%left ADD, MINUS
%left AND, OR
%left NOT
%left DIV, MULT, MOD
%left VARIABLE, CONST
%left EGALE, NEG, SUPS, INFS, INFE, SUPE

%start main
%type <Prog_type.programme> main

%%
    /* --- début des règles de grammaire --- */

main:
  | expr EOL                                  { $1 }


sexpr: /* il faut mettre en parenthese une expression qui n'est pas "simple" (evite les shifts reduces */
  | VARIABLE					                 { Var($1) }
  | CONST					                     { Const($1) }
  | LPAREN expr RPAREN                           { $2 }
;
expr:
  /* règles générales  */
  | IF expr THEN expr ELSE expr		              { IfThenElse($2,$4,$6) }
  | PRINT expr					                  { PrInt($2) }
  | LET VARIABLE EGALE expr IN expr		          { Let($2,$4,$6) }
  | LPAREN expr RPAREN 			                  { $2 }
  | expr EINSTR expr				              { Imp($1,$3) } /* séquencement */

 /* definition de fonction */
  | LET VARIABLE LPAREN RPAREN EGALE expr IN expr { Let($2, Function_def(Var("nothing"),$6), $8 ) }
  | LET VARIABLE fun_arg IN expr 			      { Let($2, $3, $5) }
  | LET REC VARIABLE fun_arg IN expr 		      { Let($3, $4, $6) }
  | fun_def                                       { $1 }


 /* exceptions */
  | TRY expr WITH EXCEPT VARIABLE IMPLIES expr    { $2 }
  | RAISE sexpr                                   { $2 }

 /* reference */
  | LET VARIABLE EGALE REF expr IN expr		     { Let($2,$5,$7) }
  | ACCESS VARIABLE                              { Var($2) }
  | VARIABLE AFFECT sexpr                        { $3 }

 /* Expression arithmétique */
  | expr ADD expr				                 { BinOp ($1, Add, $3) }
  | expr MINUS expr			                     { BinOp ($1, Minus, $3) }
  | MINUS expr								     { UnOp(Neg, $2) }
  | expr MULT expr			                     { BinOp ($1, Mult, $3) }
  | expr DIV expr				                 { BinOp ($1, Div, $3) }
  | expr MOD expr				                 { BinOp ($1, Mod, $3) }
  | VARIABLE					                 { Var($1) }
  | CONST					                     { Const($1) }

 /* Expression booléenne */
  | expr AND expr				                 { BinOp($1,And,$3) }
  | expr OR expr				                 { BinOp($1,Or,$3) }
  | NOT expr                                     { UnOp(Not,$2) }
  | expr EGALE expr				                 { BinOp($1, Equal ,$3) }
  | expr NEG expr				                 { BinOp($1, Neq ,$3) }
  | expr SUPS expr				                 { BinOp($1, Sup ,$3) }
  | expr INFS expr				                 { BinOp($1, Inf ,$3) }
  | expr SUPE expr				                 { BinOp($1, Supeq ,$3) }
  | expr INFE expr				                 { BinOp($1, Infeq ,$3) }

  | funct_call								     { $1 }
  | VARIABLE UNIT                                { Function_call( Var($1), Const(1) ) }
;

/* Arguments de fonctions */
fun_arg:
  | VARIABLE fun_arg						     { Function_def(Var($1), $2) }
  | VARIABLE EGALE expr                          { Function_def(Var($1), $3) }
;

fun_def:
  | FUN VARIABLE IMPLIES expr                    { Function_def(Var($2), $4) }
;

/* Appels de fonctions */
funct_call:
  | funct_call sexpr                              { Function_call($1, $2) }
  | sexpr sexpr                                   { Function_call($1, $2) }
;
