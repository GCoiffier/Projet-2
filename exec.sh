make;
./main.native;
for file in *.dot; do
  dot -Tpdf $file -o $file.pdf;
done;
./evince test.dot.pdf
