%{
(* --- pr�ambule: ici du code Caml --- *)

(* open Formula    rappel: dans expr.ml:
             type expr = Const of int | Add of expr*expr | Mull of expr*expr *)

%}
/* description des lex�mes, ceux-ci sont d�crits (par vous) dans lexer.mll */

%token <int> INT       /* le lex�me INT a un attribut entier */
%token MINUS FAIL SUCCESS FIN
%token SAT UNSAT

%start main             /* "start" signale le point d'entr�e: */
                        /* c'est ici main, qui est d�fini plus bas */
%type < bool* ((int*bool)) list > main     /* on _doit_ donner le type associ� au point d'entr�e */

%%
    /* --- d�but des r�gles de grammaire --- */
                            /* � droite, les valeurs associ�es */


main:                       /* <- le point d'entrée (cf. + haut, "start") */
  | SAT liste               { (true, $2) }
  | UNSAT		    { (false, []) }
;
liste:			    /* r�gles de grammaire pour les expressions */
  | INT	liste		    { ($1,true)::$2 }
  | MINUS INT liste	    { ($2,false)::$3 }
  | FIN			    { [] }
;
