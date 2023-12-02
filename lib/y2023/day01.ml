open Core

let solve str =
    let rec solve ?(y=0) ?(first='x') ?(last='x') xs =
        let (^^) a b = Char.to_string a ^ Char.to_string b in
        let sum_val first last = y + int_of_string (first ^^ last) in
        let parse x xs =
            if not @@ Char.is_digit x
            then solve ~y ~first ~last xs 
            else let first = 
                if phys_equal first 'x' 
                then x 
                else first in 
            solve ~y ~first ~last:x xs in 
        match xs with
        | [] -> sum_val first last
        | ('\n'::xs) -> solve ~y:(sum_val first last) xs
        | (x::xs) -> parse x xs in
    str 
    |> String.to_list 
    |> solve 
    |> string_of_int
