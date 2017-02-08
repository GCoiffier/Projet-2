%{
%}
/* description des lexèmes */

%token <int> INT       /* le lexème INT a un attribut entier */
%token EOL             /* retour à la ligne */

%start main             /* "start" signale le point d'entrée: c'est ici main */
%type <int> main     /* on _doit_ donner le type du point d'entrée */

%%
    /* --- début des règles de grammaire --- */
                            /* à droite, les valeurs associées */
main:                       /* le point d'entrée */
    INT EOL                { $1 }  /* on veut reconnaître un entier */
;


