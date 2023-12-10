let print f x y =
    let res = f x in 
    let () = print_int res in
    let () = print_newline () in
    res = y;;
