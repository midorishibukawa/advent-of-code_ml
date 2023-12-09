open Batteries
open Util

let digit_map = StringMap.of_list
    [ "one"  , 1
    ; "two"  , 2
    ; "three", 3
    ; "four" , 4
    ; "five" , 5
    ; "six"  , 6
    ; "seven", 7
    ; "eight", 8
    ; "nine" , 9 ];;

let get_digit_opt str =
    let k = try Enum.find (String.starts_with str) (StringMap.keys digit_map)
            with Not_found -> "" in
    StringMap.find_opt k digit_map;;

let rec solve ?(y=0) ?(first=0) ?(last=0) ~bonus xs =
    let sum_val () = first * 10 + last in
    match xs with
        | [] -> y + sum_val ()
        | ('\n'::xs) -> solve ~y:(y + sum_val ()) ~bonus xs
        | (hd::tl) -> 
                if bonus 
                then solve_bonus ~y ~first ~last hd tl xs
                else parse ~y ~first ~last ~bonus hd tl

and parse ~y ~first ~last ~bonus hd tl =
    if not @@ Char.is_digit hd
    then solve ~y ~first ~last ~bonus tl
    else 
        let x = to_digit hd in
        let first = if first = 0 then x else first in 
        solve ~y ~first ~last:x ~bonus tl

and solve_bonus ~y ~first ~last hd tl xs =
    match xs |> List.take 5 |> String.of_list |> get_digit_opt with 
    | Some digit -> 
            let first = if first = 0 then digit else first in 
            solve ~y ~first ~last:digit ~bonus:true tl
    | None -> parse ~y ~first ~last ~bonus:true hd tl;;

let solve ~bonus str =
    str 
    |> String.to_list 
    |> solve ~bonus;;
