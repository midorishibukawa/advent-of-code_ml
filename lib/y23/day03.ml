open Batteries
open Util

let look_around ~i ~j xss = 
    let adj_l = List.of_enum (-1--1) in
    let make_tuple di = List.map (fun dj -> (di, dj)) adj_l in
    let adjs = List.concat_map make_tuple adj_l in
    let get_coord (di, dj) = i + di, j + dj in
    let adjs' = List.map get_coord adjs in
    let is_symbol_adj (i, j) =
        try 
            let xs = List.at xss j in 
            let x = List.at xs i in 
            not (Char.is_digit x || Char.equal '.' x)
        with Invalid_argument _ -> false in
    try let _ = List.find is_symbol_adj adjs' in true
    with Not_found -> false;;

let rec solve ?(y=0) ?(num=0) ?(is_valid=false) ?(i=0) ?(j=0) xss =
    let num' = if is_valid then num else 0 in
    if j >= List.length xss 
    then y + num' 
    else let xs = List.at xss j in 
    if i >= List.length xs
    then solve ~y:(y + num') ~j:(j + 1) xss 
    else let x = List.at xs i in 
    if not @@ Char.is_digit x 
    then 
        let y = y + if is_valid then num else 0 in 
        solve ~y ~i:(i + 1) ~j xss 
    else 
        let is_valid = is_valid || look_around ~i ~j xss in 
        solve ~y ~num:(num * 10 + to_digit x) ~is_valid ~i:(i + 1) ~j xss;;

let solve ~bonus:_ str =
    str
    |> String.split_on_char '\n'
    |> List.map String.to_list
    |> solve;;
