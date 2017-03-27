#### Projet-2
Projet 2 2017, L3IF ENS Lyon
Coiffier Guillaume - Valque Léo

# Remarques générales

- Addresse du dépôt Git : https://github.com/GCoiffier/Projet-2

- Les fichiers de tests sont situés dans le dossier Input. Il est conseillé d'écrire les sorties du programme dans le dossier Output (pour des raisons de lisibilité)

# Comment exécuter le programme

- Pour compiler le programme, utilisez simplement la commande `make`. Celle-ci crée un exécutable appelé **f2bdd**.

- Pour nettoyer le répertoire de travail, utilisez la commande `make clean`. Cela supprime les exécutables, les fichiers .dot et les .pdf

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

[ ] Lexer et parserz

[ ]

[ ]

[ ]

[ ]

# Liste et contenu des fichiers

### main.ml :
Fichier principal. Se contente d'appeller **argv_call ()**

### fouine.ml :

### expr.ml :

### argv.ml :
Lit les argument envoyés au programme et fait les différents appels aux différentes parties du code.

### parser.mly , lexer.mll
Ces fichiers permettent de lire la formule donnée en entrée par le programme, et de construire une formule de type formula.
