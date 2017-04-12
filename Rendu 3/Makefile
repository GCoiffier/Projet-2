all:
	ocamlbuild -yaccflag -v -lib unix main.native; ln -fs main calc
	mv main.native fouine

byte:
	ocamlbuild -yaccflag -v f2bdd.byte

clean:
	rm -rf calc
	rm -rf fouine
	rm -rf -f _build
	rm -f *.native
	rm -f *.byte
	rm -f *~
