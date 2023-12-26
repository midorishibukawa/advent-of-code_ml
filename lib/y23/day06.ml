open Batteries
open Util

type phase = Time | Distance
type lookup = Left | Right

let get_distance tmax t = t * (tmax - t);;

let get_times tmax record =
    let (p, q) =
        let tmax = Int.to_float tmax in 
        let record = Int.to_float (record * -1) in 
        let open Float in 
        let disc = sqrt @@ tmax * tmax + 4.0 * record in 
        let x snd = div ((-1.0 * tmax) + disc * if snd then 1.0 else -1.0) (-2.0) in
        let (p, q) = (x true, x false) in
        let (p, q) =
            if p > q 
            then (q, p) 
            else (p, q) in
        (to_int @@ ceil p, to_int @@ floor q) in
    let get_distance = get_distance tmax in
    let p = if get_distance p = record then p + 1 else p in
    let q = if get_distance q = record then q - 1 else q in
    q - p + 1;;

let rec solve ?(time=[]) ?(distance=[]) ?(phase=Time) ~bonus xs =
    let solve = solve ~bonus in 
    match xs with 
    | [] -> if not bonus 
            then 
                List.fold_left2
                (fun acc ts ds -> acc * get_times ts ds)
                1
                time 
                distance
            else 
                let concat_nums nums = int_of_string @@ List.fold (fun acc num -> acc ^ string_of_int num) "" (List.rev nums) in
                get_times (concat_nums time) (concat_nums distance)
    | ('\n'::xs') -> solve ~time ~phase:Distance xs'
    | (x::xs') ->
            if Char.is_digit x
            then 
                let (num, xs') = get_num xs in 
                if phase = Time 
                then solve ~time:(num::time) ~phase xs'
                else solve ~time ~distance:(num::distance) ~phase xs'
            else solve ~time ~distance ~phase xs';;


let solve ~bonus str =
    str
    |> String.to_list 
    |> solve ~bonus
