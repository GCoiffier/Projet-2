let n = ref 0 in
let rec add u = if !n<20 then (n := !n + 1; prInt !n; add u) else 0 in
	add 0;;
