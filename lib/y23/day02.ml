open Batteries
open Util

let cube_map = StringMap.of_list
    [ "red"  , 12
    ; "green", 13
    ; "blue" , 14 ];;

let get_colour_qty str =
    let colour = 
        try Enum.find (String.starts_with str) (StringMap.keys cube_map) 
        with Not_found -> "" in 
    try StringMap.find colour cube_map with Not_found -> 0;;

let rec remove_til_next is_valid xs =
    match xs with
    | [] | ('\n'::_) -> xs
    | (';'::xs') | (','::xs') ->
        if is_valid 
        then xs'
        else remove_til_next is_valid xs'
    | (_::xs') -> remove_til_next is_valid xs';;
                
let rec remove_spaces xs =
    match xs with 
    | (' '::xs') -> remove_spaces xs' 
    | _ -> xs;;

let is_valid qty xs =
    let colour_qty = 
        xs 
        |> List.take 5 
        |> String.of_list 
        |> get_colour_qty in
    let is_valid = colour_qty > 0 && qty <= colour_qty in 
    (is_valid, remove_til_next is_valid xs);;

let rec solve ?(y=0) ?(game=0) xs =
    match xs with
    | [] -> y + game
    | ('\n'::xs') -> solve ~y:(y + game) xs'
    | ('G'::'a'::'m'::'e'::' '::xs') -> 
            let (game, xs') = get_num xs' in 
            solve ~y ~game xs'
    | (x::xs') -> 
            if Char.is_digit x
            then 
                let (qty, xs') = get_num xs in 
                let (is_valid, xs') = 
                    xs' 
                    |> remove_spaces 
                    |> is_valid qty in 
                if is_valid 
                then solve ~y ~game xs'
                else solve ~y xs'
            else solve ~y ~game xs';;

let get_colour str =
    try Enum.find (String.starts_with str) (StringMap.keys cube_map)
    with Not_found -> "";;

let rec solve_bonus ?(y=0) ?(map=StringMap.empty) xs =
    let product_of_map map =
        if StringMap.is_empty map 
        then 0
        else map |> StringMap.values |> Enum.fold (fun acc qty -> acc * qty) 1 in 
    match xs with 
    | [] -> y + product_of_map map
    | ('\n'::xs') -> solve_bonus ~y:(y + product_of_map map) xs'
    | ('G'::'a'::'m'::'e'::' '::xs') ->
            let (_, xs') = get_num xs' in 
            solve_bonus ~y ~map xs'
    | (x::xs') ->
            if Char.is_digit x
            then 
                let (qty, xs') = get_num xs in 
                let key = 
                    xs' 
                    |> remove_spaces
                    |> List.take 5
                    |> String.of_list 
                    |> get_colour in
                let opt_data = StringMap.find_opt key map in
                let map = 
                    if Option.is_none opt_data || qty > (Option.get opt_data)
                    then StringMap.add key qty map
                    else map in
                solve_bonus ~y ~map xs'
            else solve_bonus ~y ~map xs';;

let solve ~bonus str =
    let solve xs = solve xs in
    let solve_bonus xs = solve_bonus xs in
    str 
    |> String.to_list 
    |> (if bonus then solve_bonus else solve);;
