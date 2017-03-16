make clean;
make;
./f2bdd -tseitin -minisat input.txt;
for file in *.dot; do
  dot -Tpdf $file -o $file.pdf;
  evince $file.pdf;
done;
