let rec fiboIntelligent n x sx=
	if n=0 || n=1
	then 0
	else (
		let z = !sx in
		sx := !sx + !x;
		x := z;
		prInt !sx; fiboIntelligent (n-1) x sx
	) in let x = ref 1 in let sx = ref 1 in
	fiboIntelligent 10 x sx ;;
