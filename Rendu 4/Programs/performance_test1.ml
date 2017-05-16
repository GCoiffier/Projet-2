let n = 100000 in
let t = aMake n in
let rec fa i k =
	if i>=n
	then ()
	else (t.(i) <- 1; fa (i+k) k)
	in
let isPrime k =
	if t.(k)=0
	then (prInt k; fa k k)
	else () in
let rec fb k =
	if k>=n
	then ()
	else (isPrime k; fb (k+1) ) in
fb 2 ;;
