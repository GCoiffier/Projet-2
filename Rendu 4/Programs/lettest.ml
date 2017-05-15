let f x = x in
    let f x = f x in
        let x = ref 0 in f 3;;
