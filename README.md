# Projet-2
Projet 2 2017, L3IF ENS Lyon
Coiffier Guillaume - Valque Léo

## Remarques générales

[x] Addresse du dépôt Git : https://github.com/GCoiffier/Projet-2

[x] Pour exécuter le programme :
    './nom_executable fichier' se contente d'afficher la taille du bdd avec pour entrée l'expression contenu dans
    fichier. Si la formule n'est pas valide, il affiche erreur de saisie

    './__ -tseitin sortie entree' ecrira la formule SAT de l'entree dans le fichier sortie sous le format DIMACS

    './__ -minisat entree' appelera minisat sur la formule d'entree et affiche la comparaison avec la bdd
    il est possible de faire -minisat -tseitin ( dans cet ordre ) pour stocker la formule SAT dans le fichier sortie et
    appeler minisat

    './__ -display entree' appelera le lexer-parser sur le fichier entree pour obtenir une formule, construit le ROBDD associé à la formule et l'exporte en fichier .dot
      Pour visualiser le fichier.dot, générez le pdf avec 'dot -Tpdf file -o file.pdf; '
      Sinon, utilisez directement le script display.sh qui fera tout à votre place (commande './display.sh  <nom_fichier>', où le fichier est placé dans le dossier Inputs)

[x] Les fichiers de tests sont situés dans le dossier Input. Nous avons également écrit un fichier python qui génère des instances de test.
    Il est conseillé d'écrire les sorties du programme dans le dossier Output (pour des raisons de lisibilité)

## Avancement

[x] Lexer et parser pour les formules booléennes

[x] Type formula et fonctions utilitaires sur ce type

[x] Implémentation des BDD sans la compression

[x] Implémentation des BDD avec la compression

[x] Affichage d'un BDD en format .dot

[x] Transformation de Tseitin pour renvoyer des formules en forme SAT

[x] Exportation des fichiers pour minisat

[x] Lexer-parser pour lire les fichiers de sortie de minisat

[x] Comparaison du résultat de minisat avec le BDD

# Liste et contenu des fichiers

## f2bdd.ml :
Fichier principal. Se contente d'appeller argv_call()

## formula.ml :
Type formula et définition de quelques fonctions utilitaires sur les formules logiques :
  affichage dans la console, calcul de taille et test d'une valuation

## BDDsig.mli / BDD.ml :
  La signature et la définition du module permettant de construire des ROBDD. (Voir BDDsig.mli pour la documentation)
  Le fichier BDD.ml contient également un module Lookup, implémenté avec Set, qui permet de gérer le partage mémoire.

## valuation.ml :
  Contient deux structures de données :
    - Valuation, qui est une Map d'int, représentant une valuation des variables d'une formule. On définit également une fonction permettant de convertir une liste d'associations en Valuation
    - Var, un Set d'int, qui est utilisée pour obtenir la liste des variables d'une fonction (et gestion des doublons)

## Tseitin.ml :
contient les fonctions tseitin et reduction (et les fonctions qu'ils
appellent)

tseitin : formula -> formula
  transforme une expression en une variante CNF par la méthode de tseitin

reduction : formula -> formula
  reduit la taille d'une expression de type CNF (normalement elle marche aussi sur les autres expressions mais est moins efficace)
  il peut nécessaire de l'appeler plusieurs fois pour avoir quelque chose de taille minimale

reduction_full : formula -> formula
  applique reduction jusqu'a que l'expression soit de taille minimale

## lexParInterface.ml
contient read_formula et read_minisat pour les lires les entrées du terminal et de minisat. Fichier .ml faisait l'interface avec parser.mly et lexer.mll

read_formula : string -> formula
  transforme la chaine de caractère du fichier envoyer en argument en une formula

read_minisat : string -> bool * (int * bool) list
  lit le resultat renvoyer par minisat et le transforme et la renvoie sous forme d'une liste pour l'envoyer à BDD

## minisat.ml :
	contient quelque fonction pour préparer l'appelle à minisat

## argv.ml :
	lit les argument envoyés et fait les différents appels aux parties du programme
