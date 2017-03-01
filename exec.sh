make clean;
make byte;
if [ $# -eq 0 ]; then
  ./main.byte;
else
  ./main.byte < $0;
fi
for file in *.dot; do
  dot -Tpdf $file -o $file.pdf;
done;
evince test.dot.pdf;
