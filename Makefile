all:
	ocamlbuild -yaccflag -v -lib unix main.native; ln -fs main.native calc

byte:
	ocamlbuild -yaccflag -v main.byte

clean:
	rm -rf _build
	rm *.native
