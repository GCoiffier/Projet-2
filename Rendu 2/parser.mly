%{
(* --- préambule: ici du code Caml --- *)

open Prog_type

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
%type <Prog_type.programme> main

%%
    /* --- début des règles de grammaire --- */

main:
  | expr EOL                                  { $1 }

expr:
  | IF expr THEN expr ELSE expr		          { IfThenElse($2,$4,$6) }
  | PRINT expr					              { PrInt($2) }
  | LET VARIABLE EGALE expr IN expr		      { Let($2,$4,$6) }
  | LPAREN expr RPAREN 			              { $2 }
  | expr EINSTR expr				          { Imp($1,$3) } /* séquencement */

  | FUN VARIABLE IMPLIES expr                 { Function_def(Var($2), $4) }

 /* expression arithmétique */
  | expr ADD expr				              { BinOp ($1, Add, $3) }
  | expr MINUS expr			                  { BinOp ($1, Minus, $3) }
  | expr MULT expr			                  { BinOp ($1, Mult, $3) }
  | expr DIV expr				              { BinOp ($1, Div, $3) }
  | expr MOD expr				              { BinOp ($1, Mod, $3) }
  | VARIABLE					              { Var($1) }
  | CONST					                  { Const($1) }

 /* Expression booléenne */
  | expr AND expr				              { BinOp($1,And,$3) }
  | expr OR expr				              { BinOp($1,Or,$3) }
  | NOT expr                                  { UnOp(Not,$2) }
  | expr EGALE expr				              { BinOp($1, Equal ,$3) }
  | expr NEG expr				              { BinOp($1, Neq ,$3) }
  | expr SUPS expr				              { BinOp($1, Sup ,$3) }
  | expr INFS expr				              { BinOp($1, Inf ,$3) }
  | expr SUPE expr				              { BinOp($1, Supeq ,$3) }
  | expr INFE expr				              { BinOp($1, Infeq ,$3) }


  | expr expr                                  { Function_call($1, $2)}
;
