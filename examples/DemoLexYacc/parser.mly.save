%{
(* --- préambule: ici du code Caml --- *)

open Expr   (* rappel: dans expr.ml: 
             type expr = Const of int | Add of expr*expr | Mull of expr*expr *)

%}
/* description des lexèmes, ceux-ci sont décrits (par vous) dans lexer.mll */

%token <int> INT       /* le lexème INT a un attribut entier */
%token PLUS TIMES 
%token LPAREN RPAREN
%token EOL             /* retour à la ligne */

%left PLUS  /* associativité gauche: a+b+c, c'est (a+b)+c */
%left TIMES  /* associativité gauche: a*b*c, c'est (a*b)*c */


%start main             /* "start" signale le point d'entrée: */
                        /* c'est ici main, qui est défini plus bas */
%type <Expr.expr> main     /* on _doit_ donner le type associé au point d'entrée */

%%
    /* --- début des règles de grammaire --- */
                            /* à droite, les valeurs associées */


main:                       /* <- le point d'entrée (cf. + haut, "start") */
    expr EOL                { $1 }  /* on veut reconnaître un "expr" */
;
expr:			    /* règles de grammaire pour les expressions */
  | INT                     { Const $1 }
  | LPAREN expr RPAREN      { $2 } /* on récupère le deuxième élément */
  | expr PLUS expr          { Add($1,$3) }
  | expr TIMES expr         { Mul($1,$3) }
;

