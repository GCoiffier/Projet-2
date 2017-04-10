<<<<<<< HEAD
let rec add n= if (!n)<20 then (n := !n + 1; prInt !n; add n) else 0 in
	let x = ref 0 in add x;;

=======
let x = ref 1 in
    try
      x := 42 ;
      raise 1
    with
    E y -> !x ;;
>>>>>>> readme
