all:
	ocamlbuild -yaccflag -v -lib unix f2bdd.native; ln -fs f2bdd calc

byte:
	ocamlbuild -yaccflag -v f2bdd.byte

clean:
	rm -rf calc
	rm -rf f2bdd
	rm -rf -f _build
	rm -f *.native
	rm -f *.byte
	rm -f *.dot
	rm -f *.dot.pdf
	rm -f *~
