open Batteries
open Util

type phase = Seed | Title | Numbers
type converter = 
    { dst : int 
    ; src : int 
    ; rng : int };;

let rec parse_seed ?(seeds=[]) xs =
    match xs with 
    | [] -> (seeds, [])
    | ('\n'::'\n'::xs') -> (seeds, xs')
    | (x::xs') -> 
            if Char.is_digit x 
            then let (seed, xs') = get_num xs in 
            parse_seed ~seeds:(seed::seeds) xs'
            else parse_seed ~seeds xs';;

let rec parse_title xs =
    match xs with 
    | [] -> []
    | ('\n'::xs') -> xs'
    | (_::xs') -> parse_title xs';;

let rec parse_num ?(acc=[]) xs =
    match xs with
    | [] -> (List.rev acc, [])
    | ('\n'::'\n'::xs') -> (List.rev acc, xs')
    | (x::xs') ->
            let (acc, xs') =
                if not @@ Char.is_digit x 
                then (acc, xs')
                else
                    let clear_whitespace cs = 
                        match cs with 
                        | [] -> []
                        | (c::cs') -> if Char.is_whitespace c then cs' else cs in
                    let (dst, xs') = get_num xs in
                    let (src, xs') = xs' |> clear_whitespace |> get_num in 
                    let (rng, xs') = xs' |> clear_whitespace |> get_num in
                    let f = 
                        { dst = dst
                        ; src = src
                        ; rng = rng } in
                    (f::acc, xs') in
            parse_num ~acc xs';;

let rec solve ?(fss=[]) ?(seeds=[]) ?(phase=Seed) ~bonus xs =
    let solve = solve ~bonus in
    let map_seed_f value f =
        if value >= f.src && value < f.src + f.rng 
        then Some (value - f.src + f.dst)
        else None in
    let map_seed_val value fs =
        let new_val_opt = List.find_map_opt (map_seed_f value) fs in 
        match new_val_opt with
        | Some new_value -> new_value 
        | None -> value in
    let map_seed acc seed = 
        let loc = List.fold map_seed_val seed (List.rev fss) in 
        Int.min acc loc in 
    match xs with
    | [] -> 
            List.fold map_seed Int.max_num seeds
    | _ ->  match phase with
            | Seed -> let (seeds, xs') = parse_seed xs in
                    solve ~seeds ~phase:Title xs' 
            | Title -> let xs' = parse_title xs in
                    solve ~seeds ~fss ~phase:Numbers xs'
            | Numbers -> let (fs, xs') = parse_num xs in
                    solve ~seeds ~fss:(fs::fss) ~phase:Title xs'

let solve ~bonus str =
    str 
    |> String.to_list
    |> solve ~bonus;;
