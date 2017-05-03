let x = ref 2 in try (raise E 1 ; x := 3 ; !x) with E y -> !x;;
