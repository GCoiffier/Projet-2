let rec add n= if (!n)<20 then (n := !n + 1; prInt !n; add n) else 0 in
	let x = ref 0 in add x;;
