# Projet-2
Projet 2 2017, L3IF ENS Lyon
Coiffier Guillaume - Valque Léo

# Remarques générales

- Niveau du binôme : Intermédiaire

- Adresse du dépôt Git : https://github.com/GCoiffier/Projet-2

- Les fichiers de tests sont situés dans le dossier Programs. Les fichiers contenant du code fouine ont une extension .ml

# Comment exécuter le programme

- Pour compiler le programme, utilisez simplement la commande `make`. Celle-ci crée un exécutable appelé **fouine**.

- Pour nettoyer le répertoire de travail, utilisez la commande `make clean`.

- `./fouine fichier` exécute le code contenu dans **fichier** et renvoie le résultat de ce code (qui doit être un entier)

- `./fouine -debug fichier` commence par afficher le code parsé dans la console,   puis exécute le code et affiche le résultat.

- Exemples :
    - `./fouine Programs/factorielle.fouine`
    - `./fouine -debug Programs/function.fouine`

# Avancement du projet

### Semaine 1

[X] Lexer et parser de base

[X] Définition d'un type programme pour les programmes fouine

[X] Interprétation des fichiers .fouine sans les fonctions
  (ie expressions arithmétiques, booléennes, if ... then ... else et let ... in)

### Semaine 2

[X] Interprétation des fichiers .fouine avec des fonctions

[X] Interprétation des fichiers .fouine avec des fonctions récursives

### Semaine 3

[X] Gestion des exceptions

[X] Gestion des références

[X] Gestion du begin...end et du let _ = ...

[X] Ajout d'une primitive "bonus" PrStr qui renvoie 0 et affiche une string

### Le futur

[ ] Réalisation de clôtures plus intelligentes en ne considérant que les variables comprises dans l'environnement

[ ] Référence sur les fonctions

[ ] Possibilité de faire des tableaux

# L'interprétation
L'interprétation est réalisée dans la fonction execute du fichier interpreteur.ml . Cette fonction prend en argument un programme fouine parsé (de type programme) et renvoie un entier. On utilise une fonction récursive auxiliaire qui associe une valeur de type 'ret' au programme. Ensuite, on appelle la petite fonction return qui renvoie un int à partir de ce ret.

Ce type intermédiaire ret est nécessaire pour pouvoir utiliser des fonctions dans les programmes fouine. C'est le type des éléments qui sont associés à nos programmes dans l'environnement (Env.elt). Cela permet de renvoyer en interne autre chose que des entiers (ce qui est nécessaire pour les références et les fonctions). De plus, un filtrage par motif dans la fonction return permet de détecter les erreurs dynamiques (entier + fonction) ou (entier + ref) et d'obtenir des messages explicites.

# L'environnement

On utilisera des tables de hachage (Hastbl) qui associeront une valeur 'Env.elt' à une valeur 'programme'. Cette structure de donnée a le gros avantage de gérer parfaitement la portée des variables. En effet, d'après la documentation de Ocaml, lorsqu'une valeur y est assignée à la variable x dans une Hashtbl, l'ancienne valeur de x est remplacée par y. Lorsque l'on supprime l'association (x,y) dans la table, l'ancienne valeur associée à x est restaurée, ce qui est le comportement attendu.

Cette structure de donnée supporte l'ajout d'un couple d'élément, la suppression d'un élement et de son association (avec éventuelle restauration de la précédente association), la recherche d'un élement et la copie (pour pouvoir faire des clotures).

# Les fonctions et les fonctions récursives

Pour l'implémentation des fonctions, on a ajouté un constructeur Cloture au type Env.elt.  Un cloture comprend l'expression de la fonction (le A de `let f x = A in`) et une copie de l'environnement au moment de la définition de la fonction. Cette copie est "brutale" : on copie l'intégralité de l'environnement sans chercher à savoir quelles valeurs sont inutiles.

Dans le cas des fonctions récursives, on ajoute à la clôture crée... elle-même. Ainsi, on évite de faire autant de clôtures que d'appel récursif. Cela ne pose pas de problème tant qu'il existe un cas de sortie à la fonction récursive. NOTE : il est possible qu'ainsi, on ne puisse pas faire d'effet de bord dans une fonction récursive.

Deux constructeurs sont associés aux fonctions dans le type programme :
    Function_def : appellé lors de la définition de fonction, contient l'argument (unique) et l'expression de la fonction (qui peut elle même être une fonction).
    Function_call : appellé lors de l'appel à une fonction, contient le nom de la fonction et la valeur de l'argument (qui est une expression non interprétée)
                        le nom de la fonction permet de retrouver la définition dans l'environnement. On interprète l'expression associée à la cloture en ajoutant à l'environnement de la cloture la valeur de l'argument.

# Exceptions

Pour gérer les exceptions, nous utilisons directement le mécanisme de try ... with de OCaml. Lors de la levée d'une exception, on reprend avec "with..." l'environnement que l'on avait lors du raise (il est toujours possible de faire des effets de bord, comme en Ocaml. Voir exception2.ml pour un example).
Comme dans le sujet, on omet le | après le with

# Références et aspects impératifs

Les références se font sur des entiers uniquement. Elles sont implémentées en ajoutant un constructeur Ref au type Env.elt. Ainsi, elles sont stockées dans l'environnement au même titre que les variables classiques. Lors de la création d'une référence à l'aide du mot clé ref, on ajouter Env.Ref(x) dans l'environnement. Lors de l'assignation de la référence à une autre valeur, on supprime l'assignation courante avant de réinsérer la nouvelle valeur. Accéder à la valeur d'une référence revient simplement à accéder à l'environnement (on teste juste que l'assignation de notre variable est bien une référence. Dans le cas contraire, on plante.)

# Liste et contenu des fichiers

### main.ml :
Fichier principal. Lit les argument envoyés au programme et fait les différents appels aux différentes parties du code.

### prog_type.ml
    Fichier contenant les définitions des types représentant un programme fouine dans Caml. Type unary_op, binary_op, variable, programme.

### interpreteur.ml :
    Le fichier contenant la grosse fonction d'interprétation d'un programme fouine.

### debug.ml :
    Contient la fonction debug, qui permet d'afficher un programme fouine parsé

### environnement.ml
    La définition du module Environnement, construit à l'aide d'un dictionnaire.

### LexParInterface.ml :
    Fichier faisant l'interface entre le parser et le reste du code. Fournit simplement une primitive read_prgm <fichier>.

### parser.mly , lexer.mll
Ces fichiers permettent de lire la formule donnée en entrée par le programme, et de construire un objet de type programme représentant le code à exécuter.

### Dossier de programmes
- exemples simples sur les différentes fonctionnalités de fouine (les noms des programmes sont a priori explicites)
- fibonacci récursif stupide
- fibonacci intelligent
- factorielle
- tours de Hanoi
