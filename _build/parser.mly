%{
(* --- pr�ambule: ici du code Caml --- *)

open Formula   (* rappel: dans expr.ml:
             type expr = Const of int | Add of expr*expr | Mull of expr*expr *)

%}
/* description des lex�mes, ceux-ci sont d�crits (par vous) dans lexer.mll */

%token <int> INT       /* le lex�me INT a un attribut entier */
%token AND OR NEG XOR IMP EQ MINUS FIN
%token LPAREN RPAREN
%token EOL             /* retour � la ligne */

%left FIN
%left EQ
%left IMP
%left OR  /* associativit� gauche: a*b*c, c'est (a*b)*c */
%left XOR
%left AND  /* associativit� gauche: a+b+c, c'est (a+b)+c */
%left NEG

%start main             /* "start" signale le point d'entr�e: */
                        /* c'est ici main, qui est d�fini plus bas */
%type <Formula.formula> main     /* on _doit_ donner le type associ� au point d'entr�e */

%%
    /* --- d�but des r�gles de grammaire --- */
                            /* � droite, les valeurs associ�es */


main:                       /* <- le point d'entr�e (cf. + haut, "start") */
    expr EOL                { $1 }  /* on veut reconna�tre un "expr" */
;
expr:			    /* r�gles de grammaire pour les expressions */
  | expr FIN		  { $1 }
  | INT                   { Var $1 }
  | MINUS INT             { NOT(Var $2) }
  | LPAREN expr RPAREN    { $2 } /* on r�cup�re le deuxi�me �l�ment */
  | expr AND expr         { AND($1,$3) }
  | expr OR expr          { OR($1,$3) }
  | NEG expr              { NOT($2) }
  | expr XOR expr         { XOR($1,$3) }
  | expr IMP expr         { IMPLIES($1,$3) }
  | expr EQ  expr         { EQUIV($1,$3) }
;
