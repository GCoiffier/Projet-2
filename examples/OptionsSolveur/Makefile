all: 
	ocamlbuild -yaccflag -v -lib unix main.native; ln -fs main.native calc

byte: 
	ocamlbuild -yaccflag -v main.byte

clean: 
	ocamlbuild -clean

examples:
	echo "je recupere les exemples"; wget http://perso.ens-lyon.fr/daniel.hirschkoff/P2/docs/rendu2.pdf 
