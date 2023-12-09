module S = Core.String

let rec solve ?(y=0) ?(num=0) xs =
    match xs with
    | [] -> y + num 
    | (x::xs) -> 

let solve ~bonus str =
    str 
    |> S.to_list
    |> solve
;;
