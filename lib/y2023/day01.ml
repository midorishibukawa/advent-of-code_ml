module C = Core.Char
module L = Core.List 
module M = Core.Map 
module S = Core.String

let digit_map = 
    M.of_alist_exn 
    (module S)
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
    let open Core.Continue_or_stop in
    L.fold_until 
        (M.keys digit_map)
        ~init:None
        ~f:(fun _ prefix -> 
                if S.is_prefix (L.take xs 5 |> S.of_char_list) ~prefix
                then Stop (Some prefix)
                else Continue None)
        ~finish:Fun.id;;

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
    if not @@ C.is_digit hd
    then solve ~y ~first ~last ~bonus tl
    else 
        let x = C.get_digit_exn hd in
        let first = if first = 0 then x else first in 
        solve ~y ~first ~last:x ~bonus tl

and solve_bonus ~y ~first ~last hd tl xs =
    match get_digit_opt xs with 
    | Some digit -> 
            let x = M.find_exn digit_map digit in
            let first = if first = 0 then x else first in 
            solve ~y ~first ~last:x ~bonus:true tl
    | None -> parse ~y ~first ~last ~bonus:true hd tl;;

let solve ~bonus str =
    str 
    |> S.to_list 
    |> solve ~bonus;;
