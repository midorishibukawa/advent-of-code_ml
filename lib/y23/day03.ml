open Batteries
open Util

let pos_to_str (i, j) = string_of_int i ^ "_" ^ string_of_int j;;
    
let is_symbol_adj f xss (i, j) =
    try let xs = List.at xss j in 
        let x = List.at xs i in 
        f x
    with Invalid_argument _ -> false;;

let adjs (i, j) = 
    let adj_l = List.of_enum (-1--1) in
    let make_tuple di = List.map (fun dj -> (di, dj)) adj_l in
    let adjs' = List.concat_map make_tuple adj_l in
    let get_coord (di, dj) = i + di, j + dj in
    List.map get_coord adjs';;

let look_around ~pos:(i, j) xss =
    let is_symbol x = not (Char.is_digit x || Char.equal '.' x) in
    try let _ = 
        List.find
        (is_symbol_adj is_symbol xss)
        (adjs (i, j)) in true
    with Not_found -> false;;

let look_around_bonus ~pos:(i, j) xss = 
    try let gears = 
        List.fold 
        (fun acc pos -> 
            if is_symbol_adj (Char.equal '*') xss pos 
            then StringSet.add (pos_to_str pos) acc
            else acc)
        StringSet.empty
        (adjs (i, j)) in 
    gears
    with Not_found -> StringSet.empty;;

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
        let is_valid = is_valid || look_around ~pos:(i, j) xss in 
        solve ~y ~num:(num * 10 + to_digit x) ~is_valid ~i:(i + 1) ~j xss;;

let rec solve_bonus ?(map=StringMap.empty) ?(num=0) ?(gears=StringSet.empty) ?(i=0) ?(j=0) xss =
    let add_to_map () =
        List.fold 
            (fun acc pos -> StringMap.add_to_list pos num acc) 
            map 
            (StringSet.to_list gears) in
    if j >= List.length xss 
    then 
        StringMap.values map
        |> List.of_enum
        |> List.filter (fun ns -> List.length ns = 2)
        |> List.fold (fun acc ns -> acc + List.fold Stdlib.( * ) 1 ns) 0
    else let xs = List.at xss j in 
    if i >= List.length xs 
    then solve_bonus ~map:(add_to_map()) ~j:(j + 1) xss 
    else let x = List.at xs i in 
    if not @@ Char.is_digit x 
    then solve_bonus ~map:(add_to_map ()) ~i:(i + 1) ~j xss
    else 
        let gears = StringSet.add_seq (look_around_bonus ~pos:(i, j) xss |> StringSet.to_seq) gears in
        solve_bonus ~map ~num:(num * 10 + to_digit x) ~gears ~i:(i + 1) ~j xss;;

let solve ~bonus str =
    let solve xss = solve xss in 
    let solve_bonus xss = solve_bonus xss in
    str
    |> String.split_on_char '\n'
    |> List.map String.to_list
    |> (if bonus then solve_bonus else solve);;
