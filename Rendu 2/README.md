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

[ ] Lexer et parser

[ ] Type pour les expressions booléennes et arithmétiques.
    Fonction d'évalutation

[ ] Définition d'un type programme pour les programmes fouines

[ ] Interprétation des fichiers .fouine

[ ] Compilation vers une machine à pile

[ ] Fonctionnement de la machine à pile

# Liste et contenu des fichiers

### main.ml :
Fichier principal. Se contente d'appeller **argv_call ()**

### fouine.ml :

### expr_arith.ml :

### expr_bool.ml :

### LexParInterface.ml :

###

### argv.ml :
Lit les argument envoyés au programme et fait les différents appels aux différentes parties du code.

### parser.mly , lexer.mll
Ces fichiers permettent de lire la formule donnée en entrée par le programme, et de construire une formule de type formula.
