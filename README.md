# Projet-2
Projet 2 2017, L3IF ENS Lyon
Coiffier Guillaume - Valque Léo

## Remarques générales

[x] La formule d'entrée est écrite dans le fichier input.txt
    ATTENTION : Ses variables doivent être étiquetées par les entiers de 1 à n.

[x] Pour executer le programme, utilisez le script exec.sh.
      ./exec.sh "file.txt"  execute le programme sur la formule contenue dans le fichier file.txt
      ./exec.sh seul execute le programme en mode interactif. Il faut alors entrer à la main la formule dans la console.

## Avancement

[x] Lexer et parser pour les formules booléennes

[x] Type formula et fonctions utilitaires sur ce type

[x] Implémentation des BDD sans la compression

[] Implémentation des BDD avec la compression

[] Affichage d'un BDD en format .dot

[] Transformation de Tseitin pour renvoyer des formules en forme SAT

[] Exportation des fichiers pour minisat et comparaison du résultat avec le BDD

# Liste et contenu des fichiers

##main.ml :

##formula.ml :

##BDD.ml :

##input.txt :

##Tseitin.ml :
contient les fonctions tseitin et reduction (et les fonctions qu'ils
appellent)

tseitin : formula -> formula
transforme une expression en une variante CNF par la méthode de tseitin

reduction : formula -> formula
reduit la taille d'une expression de type CNF (normalement elle marche aussi sur les autres expressions mais est moins efficace)
il peut nécessaire de l'appeler plusieurs fois pour avoir quelque chose de taille minimale

reduction_full : formula -> formula
applique reduction jusqu'a que l'expression soit de taille minimale

##API.ml
contient read_formula pour les lires les entrées du terminal

read_formula : unit -> formula
transforme la chaine de caractère de l'entrée standart en une
formula
