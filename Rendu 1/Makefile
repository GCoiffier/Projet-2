all:
	ocamlbuild -yaccflag -v -lib unix main.native; ln -fs main calc
	mv main.native f2bdd

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
