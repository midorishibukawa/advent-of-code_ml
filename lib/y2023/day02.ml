open Core

let cube_map =
    Map.of_alist_exn (module String)
    [ "red"  , 12
    ; "green", 13
    ; "blue" , 14 ];;

let take n xs = List.take xs n;;

let rec get_num ?(n=0) xs =
    match xs with
    | [] -> (n, xs)
    | (x::xs') ->
        if Char.is_digit x
        then get_num ~n:(n * 10 + (Char.get_digit_exn x)) xs'
        else (n, xs);; 

let get_colour_qty str =
    List.fold_until
    (Map.keys cube_map)
    ~init:0
    ~f:(fun _ prefix ->
        let open Core.Continue_or_stop in
        if String.is_prefix ~prefix str
        then Stop (Map.find_exn cube_map prefix)
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
                
let rec remove_spaces xs =
    match xs with 
    | (' '::xs') -> remove_spaces xs' 
    | _ -> xs;;

let is_valid qty xs =
    let colour_qty = 
        xs 
        |> take 5 
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
    List.fold_until 
    (Map.keys cube_map)
    ~init:""
    ~f:(fun _ prefix ->
        let open Core.Continue_or_stop in
        if String.is_prefix ~prefix str
        then Stop prefix
        else Continue "")
    ~finish:Fun.id;;


let rec solve_bonus ?(y=0) ?(map=Map.empty (module String)) xs =
    let product_of_map map =
        if Map.is_empty map 
        then 0
        else Map.fold 
            map 
            ~init:1 
            ~f:(fun ~key:_ ~data acc -> acc * data) in 
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
                    |> take 5
                    |> String.of_list 
                    |> get_colour in
                let opt_data = Map.find map key in
                let map = 
                    if Option.is_none opt_data || qty > (Option.value_exn opt_data)
                    then Map.set map ~key ~data:qty 
                    else map in
                solve_bonus ~y ~map xs'
            else solve_bonus ~y ~map xs';;

let solve ~bonus str =
    let solve xs = solve xs in
    let solve_bonus xs = solve_bonus xs in
    str 
    |> String.to_list 
    |> (if bonus then solve_bonus else solve);;
