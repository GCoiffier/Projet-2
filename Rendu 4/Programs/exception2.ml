let x = ref 1 in
    try
      x := 42 ;
      raise E 1;
      x := 12
    with
    E y -> !x ;;
