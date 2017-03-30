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

# L'environnement

On utilisera des tables de hachage (Hastbl).

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
