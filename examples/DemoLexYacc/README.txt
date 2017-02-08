
pour compiler, lancer
make

pour executer le programme, lancer
./calc

entrer une expression arithmetique (avec juste + et *)



lors de la compilation de l'analyseur syntaxique (ocamlyacc), 
allez contempler le fichier "parser.output" dans le repertoire _build
(en cherchant le message d'erreur, qui indique quelles regles sont
entrees en conflit)


Exemple: dans parser.mly, supprimez la ligne commencant par "%left
TIMES", sauvegardez, et recompilez. En principe, vous voyez apparaitre
des messages "shift/reduce conflicts" lors de la compilation (qui
aboutit neanmoins: une ambiguite est signalee, mais une decision par
defaut est prise).

Ouvrez alors le fichier parser.output qui se trouve dans le
sous-repertoire _build/

Vous voyez que le fichier commence par associer des nombres entre
parentheses aux regles de grammaire:

   1  main : expr EOL

   2  expr : INT
   3       | LPAREN expr RPAREN
   4       | expr PLUS expr
   5       | expr TIMES expr


en cherchant "conflict" dans le fichier, vous tombez sur:

<<
12: shift/reduce conflict (shift 9, reduce 4) on TIMES
state 12
	expr : expr . PLUS expr  (4)
	expr : expr PLUS expr .  (4)
	expr : expr . TIMES expr  (5)

	TIMES  shift 9
	PLUS  reduce 4
	RPAREN  reduce 4
	EOL  reduce 4
>>

L'etat 12 de l'automate signale une ambiguite: il a le choix entre
d'une part faire "shift" lorsqu'il lit TIMES, puis passer a l'etat 9,
et d'autre part faire "reduce" pour reconnaitre qu'il peut appliquer
la regle 4. Par defaut, on lit qu'il fait shift, ce qui le conduit a
l'etat 9, ou l'on peut voir que le TIMES a ete empile (le point s'est
"deplace sur la droite"):

state 9
	expr : expr TIMES . expr  (5)

