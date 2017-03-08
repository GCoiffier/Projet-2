make clean;
make;
if [ $# -eq 0 ]; then
  ./main.native;
else
  ./main.native < $0;
fi
for file in *.dot; do
  dot -Tpdf $file -o $file.pdf;
  evince $file.pdf;
done;
make clean;
