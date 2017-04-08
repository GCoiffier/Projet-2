#### Projet-2
Projet 2 2017, L3IF ENS Lyon
Coiffier Guillaume - Valque Léo

# Remarques générales

- Niveau du binôme : Intermédiaire

- Adresse du dépôt Git : https://github.com/GCoiffier/Projet-2

- Les fichiers de tests sont situés dans le dossier Programs. Les fichiers contenant du code fouine ont une extension .fouine

# Comment exécuter le programme

- Pour compiler le programme, utilisez simplement la commande `make`. Celle-ci crée un exécutable appelé **fouine**.

- Pour nettoyer le répertoire de travail, utilisez la commande `make clean`.

- `./fouine fichier` exécute le code contenu dans **fichier** et renvoie le résultat de ce code (qui doit être un entier)

- `./fouine -debug fichier` commence par afficher le code parsé dans la console,   puis exécute le code et affiche le résultat.

- Exemples :
    - `./fouine Programs/factorielle.fouine`
    - `./fouine -debug Programs/function.fouine`

# Avancement du projet

[X] Lexer et parser

[X] Définition d'un type programme pour les programmes fouines

[X] Interprétation des fichiers .fouine sans les fonctions
  (ie expressions arithmétiques, booléennes, if ... then ... else et let ... in)

[X] Interprétation des fichiers .fouine avec des fonctions

[X] Interprétation des fichiers .fouine avec des fonctions récursives

[X] Gestion des exceptions

[X] Gestion des références

[] Gestion du begin...end et du let _ = ...


# L'interprétation
L'interprétation est réalisée dans la fonction execute du fichier interpreteur.ml . Cette fonction prend en argument un programme fouine parsé (de type programme) et renvoie un entier. On utilise une fonction récursive auxiliaire qui associe une valeur de type 'ret' au programme. Ensuite, on appelle la petite fonction return qui renvoie un int à partir de ce ret.

Ce type intermédiaire ret est nécessaire pour pouvoir utiliser des fonctions dans les programmes fouine. C'est le type des éléments qui sont associés à nos programmes dans l'environnement (Env.elt). Cela permet de renvoyer en interne autre chose que des entiers (ce qui est nécessaire pour les références et les fonctions). De plus, un filtrage par motif dans la fonction return permet de détecter les erreurs dynamiques (entier + fonction) ou (entier + ref) et d'obtenir des messages explicites.

# L'environnement

On utilisera des tables de hachage (Hastbl) qui associeront une valeur 'Env.elt' à une valeur 'programme'. Cette structure de donnée a le gros avantage de gérer parfaitement la portée des variables. En effet, d'après la documentation de Ocaml, lorsqu'une valeur y est assignée à la variable x dans une Hashtbl, l'ancienne valeur de x est remplacée par y. Lorsque l'on supprime l'association (x,y) dans la table, l'ancienne valeur associée à x est restaurée, ce qui est le comportement attendu.

Cette structure de donnée supporte l'ajout d'un couple d'élément, la suppression d'un élement et de son association (avec éventuelle restauration de la précédente association), la recherche d'un élement et la copie (pour pouvoir faire des clotures).

# Les fonctions et les fonctions récursives

- Implémentation de la clôture.
- Clôture qui se contient elle même pour les fonctions récursives.
- Suggestion de Bertrand pour le parsing de plusieurs arguments (utiliser un type d'expression simple_expr (sexpr) qui est tout sauf une fonction)
- copie "brutale" de l'environnement en entier. On ne cherche pas à savoir quelles sont les valeurs dont on a besoin

# Les exceptions

- utilisation du mécanisme de try ... with de OCaml directement. Impression de truander.

# Les références

- ajout de la règle `let x = expr ; expr` dans le parser.
- ajout du constructeur Ref au type elt de l'environnement.

# Bugs connus et non corrigés

- `let f x y = (x+2)*(y+1) in f 3 4;;` plante au parsing, alors que
  `let f x y = ((x+2)*(y+1)) in f 3 4;;` fonctionne parfaitement

- `x := 40 + 2; !x ;;` renvoie 40
  `x := (40 +2) ; !x ;;` renvoie 42

# Liste et contenu des fichiers

### main.ml :
Fichier principal. Lit les argument envoyés au programme et fait les différents appels aux différentes parties du code.

### prog_type.ml
    Fichier contenant les définitions des types représentant un programme fouine dans Caml. Type unary_op, binary_op, variable, programme.


### interpreteur.ml :

### debug.ml

### environnement.ml

### LexParInterface.ml :

### parser.mly , lexer.mll
Ces fichiers permettent de lire la formule donnée en entrée par le programme, et de construire un objet de type programme représentant le code à exécuter.

### Dossier de programmes
- programme d'exemple sur les exceptions
- programme codant la suite de fibonacci récursive
- programme codant la factorielle
- programme d'exemple sur les fonctions à plusieurs arguments
