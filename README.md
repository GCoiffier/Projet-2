# Projet-2
Projet 2 2017, L3IF ENS Lyon
Coiffier Guillaume - Valque Léo

## Remarques générales

[x] La formule d'entrée est écrite dans le fichier input.txt

## Liste et contenu des fichiers

#Tseitin.ml :
contient les fonctions tseitin et reduction (et les fonctions qu'ils
appellent)

tseitin : formula -> formula
transforme une expression en une variante CNF par la méthode de tseitin

reduction : formula -> formula
reduit la taille d'une expression de type CNF (normalement elle marche aussi sur les autres expressions mais est moins efficace)
il peut nécessaire de l'appeler plusieurs fois pour avoir quelque chose de taille minimale

#API.ml
contient read_formula pour les lires les entrées du terminal

read_formula : unit -> formula
transforme la chaine de caractère de l'entrée standart en une
formula