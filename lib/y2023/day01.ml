open Core

let digit_map = 
    Map.of_alist_exn 
    (module String)
    [ "one"  , 1
    ; "two"  , 2
    ; "three", 3
    ; "four" , 4
    ; "five" , 5
    ; "six"  , 6
    ; "seven", 7
    ; "eight", 8
    ; "nine" , 9 ];;

let get_digit_opt xs =
    let open Base.Container.Continue_or_stop in
    List.fold_until 
        (Map.keys digit_map)
        ~init:None
        ~f:(fun _ prefix -> 
                if String.is_prefix (List.take xs 5 |> String.of_char_list) ~prefix
                then Stop (Some prefix)
                else Continue None)
        ~finish:(fun acc -> acc);;

let rec solve ?(y=0) ?(first=0) ?(last=0) ?(bonus=false) xs =
    let sum_val = lazy (first * 10 + last) in
    match xs with
        | [] -> y + Lazy.force sum_val
        | ('\n'::xs) -> solve ~y:(y + Lazy.force sum_val) ~bonus xs
        | (hd::tl) -> 
                if bonus 
                then solve_bonus ~y ~first ~last hd tl xs
                else parse ~y ~first ~last ~bonus hd tl

and parse ~y ~first ~last ~bonus hd tl =
    if not @@ Char.is_digit hd
    then solve ~y ~first ~last ~bonus tl
    else 
        let x = Char.get_digit_exn hd in
        let first = if first = 0 then x else first in 
        solve ~y ~first ~last:x ~bonus tl

and solve_bonus ~y ~first ~last hd tl xs =
    match get_digit_opt xs with 
    | Some digit -> 
            let x = Map.find_exn digit_map digit in
            let first = if first = 0 then x else first in 
            solve ~y ~first ~last:x ~bonus:true tl
    | None -> parse ~y ~first ~last ~bonus:true hd tl;;

let solve ~bonus str =
    str 
    |> String.to_list 
    |> solve ~bonus
    |> string_of_int;;
