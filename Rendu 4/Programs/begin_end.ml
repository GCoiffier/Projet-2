let x = ref 3 in
    let y = ref 4 in
        if 2>1 then
            begin
            x := 4;
            y := 5;
            !x + !y
            end
        else 0 ;;
