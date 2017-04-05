#### Projet-2
Projet 2 2017, L3IF ENS Lyon
Coiffier Guillaume - Valque Léo

# Remarques générales

- Addresse du dépôt Git : https://github.com/GCoiffier/Projet-2

- Les fichiers de tests sont situés dans le dossier Input.

# Comment exécuter le programme

- Pour compiler le programme, utilisez simplement la commande `make`. Celle-ci crée un exécutable appelé **fouine**.

- Pour nettoyer le répertoire de travail, utilisez la commande `make clean`.

- `./fouine fichier`

- `./fouine -debug fichier`

- `./fouine -machine fichier`

- `./fouine -interm fichier`

- Exemples :  

# Avancement du projet

[X] Lexer et parser

[X] Définition d'un type programme pour les programmes fouines

[X] Interprétation des fichiers .fouine sans les fonctions
  (ie expressions arithmétiques, booléennes, if ... then ... else et let ... in)

[ ] Interprétation des fichiers .fouine avec des fonctions

[ ] Interprétation des fichiers .fouine avec des fonctions récursives

[ ] Compilation vers une machine à pile

[ ] Fonctionnement de la machine à pile

# L'interprétation
L'interprétation est réalisée dans la fonction execute du fichier interpreteur.ml . Cette fonction prend en argument un programme fouine parsé (de type programme) et renvoie un entier. On utilise une fonction récursive auxilliaire qui associe une valeur de type 'ret' au programme. Ensuite la petite fonction return qui renvoie un int à partir de ce ret.

Ce type intermédiaire ret est nécessaire pour pouvoir utiliser des fonctions. C'est le type des éléments qui sont associés à nos programmes dans la table de hachage (Env.elt).
Lorsque l'on doit interpréter la définition d'une fonction, la seule possibilité et de renvoyer la clôture associée (qui sera rattrapée dans la deuxième moitié de l'exécution d'un let... in ...). Env.elt est alors soit un int, soit une clôture.

# L'environnement

On utilisera des tables de hachage (Hastbl). Cette structure de donnée a le gros avantage de gérer parfaitement la portée des variables. En effet, d'après la documentation de Ocaml, lorsqu'une valeur y est assignée à la variable x dans une Hashtbl, l'ancienne valeur de x est remplacée par y. Lorsque l'on supprime l'association (x,y) dans la table, l'ancienne valeur associée à x est restaurée !

# Liste et contenu des fichiers

### main.ml :
Fichier principal. Se contente d'appeller **argv_call ()**

### fouine.ml :

### LexParInterface.ml :

###

### argv.ml :
Lit les argument envoyés au programme et fait les différents appels aux différentes parties du code.

### parser.mly , lexer.mll
Ces fichiers permettent de lire la formule donnée en entrée par le programme, et de construire une formule de type formula.
