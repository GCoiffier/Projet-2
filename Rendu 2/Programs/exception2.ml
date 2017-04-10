let x = ref 1 in
    try
      x := 42 ;
      raise 1
    with
    E y -> !x ;;
