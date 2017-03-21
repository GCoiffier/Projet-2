#### Projet-2
Projet 2 2017, L3IF ENS Lyon
Coiffier Guillaume - Valque Léo

# Remarques générales

- Addresse du dépôt Git : https://github.com/GCoiffier/Projet-2

- Les fichiers de tests sont situés dans le dossier Input. Il est conseillé d'écrire les sorties du programme dans le dossier Output (pour des raisons de lisibilité)

# Comment exécuter le programme

- `./f2bdd fichier` se contente d'afficher la taille du bdd avec pour entrée l'expression contenu dans
fichier. Si la formule n'est pas valide, il affiche erreur de saisie

- `./f2bdd -tseitin sortie entree` écrira la formule SAT de l'entree dans le fichier sortie sous le format DIMACS

- `./f2bdd -minisat entree` appelera minisat sur la formule d'entree et affiche la comparaison avec la bdd
il est possible de faire -minisat -tseitin ( dans cet ordre ) pour stocker la formule SAT dans le fichier sortie et
appeler minisat

- `./f2bdd -display entree` appellera le lexer-parser sur le fichier entree pour obtenir une formule, construit
  le ROBDD associé à la formule et l'exporte en fichier .dot

  Pour visualiser le fichier.dot, générez le pdf avec `dot -Tpdf file -o file.pdf`
  Sinon, utilisez directement le script display.sh qui fera tout à votre place (commande `./display.sh  <nom_fichier>`).
  Attention, l'affichage est relativement lent dès que le diagramme devient grand.


- Exemples :  
  `./f2bdd -tseitin Outputs/tseitin1.txt  Inputs/pomme.form`  
  `./f2bdd -minisat Inputs/input1.form`  
  `./f2bdd -minisat -tseitin Outputs/tseitin1.txt Inputs/parite.form`  
  `./display.sh Inputs/parite.form`  


# Avancement du projet

[x] Lexer et parser pour les formules booléennes (Léo)

[x] Type formula et fonctions utilitaires sur ce type (Guillaume)

[x] Implémentation des BDD sans la compression (Guillaume)

[x] Implémentation des BDD avec la compression (Guillaume)

[x] Affichage d'un BDD en format .dot (Guillaume)

[x] Transformation de Tseitin pour renvoyer des formules en forme SAT (Léo)

[x] Exportation des fichiers pour minisat (Léo)

[x] Lexer-parser pour lire les fichiers de sortie de minisat (Léo)

[x] Gestion de formules avec variables quelconques en utilisant des Map (Guillaume)

[x] Comparaison du résultat de minisat avec le BDD (Léo et Guillaume)

[x] Fichier de génération de formules booléennes pour tester le programme (Léo)

# Représentation des formules
  Le type formule est défini dans le fichier formula.ml . Les formules prennent en compte des variables quelconques
  (c'est à dire pas seulement des variables de 1 à n : 12 X 42 <=> 666 est ainsi une formule tout à fait valable).
  Ceci est accompli grâce à l'utilisation d'une Map pour représenter une valuation (fichier valuation.ml).

# Le partage dans le ROBDD
  Le partage dans le ROBDD est implémenté à l'aide d'un set 'Lookup'. La construction avec ou sans le partage est la même
  à la différence près que l'on effectue une recherche et une insertion dans le set à chaque étape.

# BDD contre DPLL : les appels à minisat
  Les appels à minisat sont effectués dans le fichier argv.ml qui utilise des fonctions de minisat.ml
  Pour récupérer la sortie de minisat, nous utilisons un second lexer/parser qui nous permet de récupérer la
  valuation retournée par minisat. Cette

# Génération des exemples de test
  Les exemples de test sont générés par un script python : generate_formula.py dans le dossier Inputs.
  Ils dépendent chacun d'un entier n :
    - parite.form -> test de la parité d'un nombre
    - pomme.form -> le principe des tiroirs
    - additionneur.form -> une addition binaire
    - rotation.form -> des rotations
  Pour regénérer les instances de test, utilisez la commande 'python3 generate_formula.py n' où n est l'entier voulu.
  Attention, dès que n dépasse 10, certains calculs deviennent très long...

# Liste et contenu des fichiers

### main.ml :
Fichier principal. Se contente d'appeller argv_call()

### formula.ml :
Type formula et définition de quelques fonctions utilitaires sur les formules logiques :
  affichage dans la console, calcul de taille et test d'une valuation

### BDDsig.mli / BDD.ml :
  La signature et la définition du module permettant de construire des ROBDD. (Voir BDDsig.mli pour une documentation plus complète)
  Le fichier BDD.ml contient également le module Lookup.

### valuation.ml :
  Contient deux structures de données :
    - Valuation, qui est une Map d'int, représentant une valuation des variables d'une formule. On définit également une fonction permettant de convertir une liste d'associations en Valuation
    - Var, un Set d'int, qui est utilisée pour obtenir la liste des variables d'une fonction (et gestion des doublons)

### tseitin.ml :
Contient les fonctions tseitin et reduction (et les fonctions qu'ils
appellent)

tseitin : formula -> formula
  transforme une expression en une variante CNF par la méthode de tseitin

reduction : formula -> formula
  reduit la taille d'une expression de type CNF (normalement elle marche aussi sur les autres expressions mais est moins efficace)
  il peut nécessaire de l'appeler plusieurs fois pour avoir quelque chose de taille minimale

reduction_full : formula -> formula
  applique reduction jusqu'a que l'expression soit de taille minimale

### lexParInterface.ml
Contient read_formula et read_minisat pour les lires les entrées du terminal et de minisat. Ce fichier .ml fait l'interface avec parser.mly et lexer.mll

read_formula : string -> formula
  transforme la chaîne de caractère du fichier envoyer en argument en une formula

read_minisat : string -> bool * (int * bool) list
  lit le résultat renvoyer par minisat et le transforme et la renvoie sous forme d'une liste pour l'envoyer à BDD.

### minisat.ml :
Contient quelques fonctions pour préparer l'appel à minisat

### argv.ml :
Lit les argument envoyés au programme et fait les différents appels aux différentes parties du code.

### generate_formula.py
  Un script python qui permet de générer des instances de test pour le programme. Pour générer de nouvelles instances de test, utilisez la commande
  'python3 generate_formula.py n' où n est un nombre. Attention, certaines formules deviennent très vite très grandes avec n.
  Par exemple, après la transformation de Tseitin, pomme(5) contient 683 variables et 985 clauses...
