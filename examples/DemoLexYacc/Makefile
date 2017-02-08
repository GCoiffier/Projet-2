all: 
	ocamlbuild -yaccflag -v -lib unix main.native; ln -fs main.native calc

byte: 
	ocamlbuild -yaccflag -v main.byte

clean: 
	ocamlbuild -clean
