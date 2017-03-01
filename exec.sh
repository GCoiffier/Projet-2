make;
if [ $# -eq 0 ]; then
  ./main.native;
else
  ./main.native $1;
fi
for file in *.dot; do
  dot -Tpdf $file -o $file.pdf;
done;
evince test.dot.pdf;
