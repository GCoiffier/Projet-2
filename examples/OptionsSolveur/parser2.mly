%{
%}
/* description des lex�mes */

%token <int> INT       /* le lex�me INT a un attribut entier */
%token EOL             /* retour � la ligne */

%start main             /* "start" signale le point d'entr�e: c'est ici main */
%type <int> main     /* on _doit_ donner le type du point d'entr�e */

%%
    /* --- d�but des r�gles de grammaire --- */
                            /* � droite, les valeurs associ�es */
main:                       /* le point d'entr�e */
    INT EOL                { $1 }  /* on veut reconna�tre un entier */
;


