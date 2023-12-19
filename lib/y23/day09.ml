open Batteries
open Util

let rec get_dif ?(difs=[]) ?(all_zero=true) ?(pre=None) xs =
    match xs with 
    | [] -> let res = 
                match pre with
                | None -> 0
                | Some pre -> pre in 
            (res, all_zero, List.rev difs)
    | (cur::xs') ->
            match pre with
            | None -> get_dif ~difs ~all_zero ~pre:(Some cur) xs'
            | Some pre ->
                let dif = cur - pre in
                let all_zero = all_zero && dif = 0 in
                get_dif ~difs:(dif::difs) ~all_zero ~pre:(Some cur) xs' 

let rec parse_dif ?(acc=0) xs =
    let (num, all_zero, dif) = get_dif xs in 
    if all_zero
    then acc + num
    else parse_dif ~acc:(acc + num) dif

let solve ~bonus:_ str =
    str 
    |> String.split_on_char '\n'
    |> List.map (String.split_on_char ' ')
    |> List.map (List.map String.to_list)
    |> List.map (List.map (fun l -> let (num, _) = get_num l in num))
    |> List.fold(fun acc l -> acc + parse_dif l) 0
