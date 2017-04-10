let rec hanoi n x y z=
	if n=0
	then 1
	else (
		hanoi (n-1) x z y;
		prStr "ring "; prInt n; prStr ": "; prInt x; prStr "to "; prInt z; prNl;
		hanoi (n-1) y x z
	) in
	hanoi 3 1 2 3;;
