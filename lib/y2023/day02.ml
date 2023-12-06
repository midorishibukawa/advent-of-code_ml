module C = Core.Char
module L = Core.List
module M = Core.Map
module S = Core.String

let cube_map =
    M.of_alist_exn (module S)
    [ "red"  , 12
    ; "green", 13
    ; "blue" , 14 ];;

let rec get_num ?(n=0) xs =
    match xs with
    | [] -> (n, xs)
    | (x::xs') ->
        if C.is_digit x
        then get_num ~n:(n * 10 + (C.get_digit_exn x)) xs'
        else (n, xs);; 

let get_colour_qty str =
    L.fold_until
    (M.keys cube_map)
    ~init:0
    ~f:(fun _ prefix ->
        let open Core.Continue_or_stop in
        if S.is_prefix ~prefix str
        then Stop (M.find_exn cube_map prefix)
        else Continue (-999))
    ~finish:Fun.id;;

let rec remove_til_next is_valid xs =
    match xs with
    | [] | ('\n'::_) -> xs
    | (';'::xs') | (','::xs') ->
        if is_valid 
        then xs'
        else remove_til_next is_valid xs'
    | (_::xs') -> remove_til_next is_valid xs';;

let rec is_valid qty xs =
    match xs with 
    | (' '::xs') -> is_valid qty xs'
    | _ ->  let colour_qty = get_colour_qty (L.take xs 5 |> S.of_list) in 
            let is_valid = colour_qty > 0 && qty <= colour_qty in 
            (is_valid, remove_til_next is_valid xs);;

let rec solve ?(y=0) ?(game=0) ~bonus xs =
    let solve = solve ~bonus in
    match xs with
    | [] -> y + game
    | ('\n'::xs') -> solve ~y:(y + game) xs'
    | ('G'::'a'::'m'::'e'::' '::xs') -> 
            let (game, xs') = get_num xs' in 
            solve ~y ~game xs'
    | (x::xs') -> 
            if C.is_digit x
            then let (qty, xs') = get_num xs in 
            let (is_valid, xs') = (is_valid qty xs') in 
                if is_valid 
                then solve ~y ~game xs'
                else solve ~y xs'
            else solve ~y ~game xs';; 

let solve ~bonus str = 
    str 
    |> S.to_list 
    |> solve ~bonus
    |> string_of_int
