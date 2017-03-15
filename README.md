# Projet-2
Projet 2 2017, L3IF ENS Lyon
Coiffier Guillaume - Valque Léo

## Remarques générales

[x] La formule d'entrée est écrite dans le fichier input.txt
    ATTENTION : Ses variables doivent être étiquetées par les entiers de 1 à n.

[x] Pour executer le programme, utilisez le script exec.sh.

## Avancement

[x] Lexer et parser pour les formules booléennes

[x] Type formula et fonctions utilitaires sur ce type

[x] Implémentation des BDD sans la compression

[x] Implémentation des BDD avec la compression

[x] Affichage d'un BDD en format .dot

[] Transformation de Tseitin pour renvoyer des formules en forme SAT

[] Exportation des fichiers pour minisat et comparaison du résultat avec le BDD

# Liste et contenu des fichiers

## main.ml :
Fichier principal. Le main lit la formule en entrée (soit de input.txt, soit donnée dans la console),
crée l'objet formula associé, construit le ROBDD associé et l'exporte au format .dot

## formula.ml :
Type formula et définition de quelques fonctions utilitaires sur les formules logiques :
  affichage dans la console, calcul de taille et test d'une valuation

## BDDsig.mli / BDD.ml :
  La signature et la définition du module permettant de construire des ROBDD. Voir BDDsig.mli pour la documentation

## visited.ml :
  Contient un module Lookup qui sert de dictionnaire lors de la construction d'un BDD. Permet d'implémenter le partage de mémoire des BDD.

## input.txt :
  Le fichier principal d'entrée. Ecrivez ici une formule à envoyer au programme

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
contient read_formula pour les lires les entrées du terminal. Fichier .ml faisait l'interface avec parser.mly et lexer.mll

read_formula : unit -> formula
  transforme la chaine de caractère de l'entrée standard en une formula

## argv.ml :
  
