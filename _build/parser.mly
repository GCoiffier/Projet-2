%{
(* --- préambule: ici du code Caml --- *)

open Formula   (* rappel: dans expr.ml: 
             type expr = Const of int | Add of expr*expr | Mull of expr*expr *)

%}
/* description des lexèmes, ceux-ci sont décrits (par vous) dans lexer.mll */

%token <int> INT       /* le lexème INT a un attribut entier */
%token AND OR NEG XOR IMP EQ MINUS FIN
%token LPAREN RPAREN
%token EOL             /* retour à la ligne */

%left FIN
%left EQ
%left IMP
%left OR  /* associativité gauche: a*b*c, c'est (a*b)*c */
%left XOR
%left AND  /* associativité gauche: a+b+c, c'est (a+b)+c */
%left NEG

%start main             /* "start" signale le point d'entrée: */
                        /* c'est ici main, qui est défini plus bas */
%type <Formula.formula> main     /* on _doit_ donner le type associé au point d'entrée */

%%
    /* --- début des règles de grammaire --- */
                            /* à droite, les valeurs associées */


main:                       /* <- le point d'entrée (cf. + haut, "start") */
    expr EOL                { $1 }  /* on veut reconnaître un "expr" */
;
expr:			    /* règles de grammaire pour les expressions */
  | expr FIN		  { $1 }
  | INT                   { Var $1 }
  | MINUS INT             { NOT(Var $2) }
  | LPAREN expr RPAREN    { $2 } /* on récupère le deuxième élément */
  | expr AND expr         { AND($1,$3) }
  | expr OR expr          { OR($1,$3) }
  | NEG expr              { NOT($2) }
  | expr XOR expr         { XOR($1,$3) }
  | expr IMP expr         { IMPLIES($1,$3) }
  | expr EQ  expr         { EQUIV($1,$3) }
;

