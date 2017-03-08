all:
	ocamlbuild -yaccflag -v -lib unix main.native; ln -fs main.native calc

byte:
	ocamlbuild -yaccflag -v main.byte

clean:
	rm -rf -f _build
	rm -f *.native
	rm -f *.byte
	rm -f *.dot
	rm -f *.dot.pdf
