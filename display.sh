make clean;
make;
./f2bdd.native -display input.form;
for file in *.dot; do
  dot -Tpdf $file -o $file.pdf;
  evince $file.pdf;
done;
