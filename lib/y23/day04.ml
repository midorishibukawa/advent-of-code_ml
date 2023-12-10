open Batteries
open Util

type phase = Skip | Winning | Actual

let rec solve ?(y=0) ?(w=(-1)) ?(ws=IntSet.empty) ?(num=0) ?(phase=Skip) xs =
    let get_points y w = y + if w < 0 then 0 else Int.pow 2 w in
    let update_w w = w + if IntSet.mem num ws then 1 else 0 in 
    match xs with 
    | [] -> get_points y @@ update_w w 
    | (':'::xs')  -> solve ~y ~phase:Winning xs'
    | ('|'::xs')  -> solve ~y ~ws ~phase:Actual xs'
    | ('\n'::xs') -> solve ~y:(get_points y @@ update_w w) ~phase:Skip xs'
    | (x::xs') -> 
            if Char.is_digit x 
            then solve ~y ~w ~ws ~num:(num * 10 + to_digit x) ~phase xs' 
            else 
                match phase with 
                | Skip -> solve ~y ~phase xs'
                | Winning -> let ws = if num = 0 then ws else IntSet.add num ws in
                        solve ~y ~ws ~phase xs'
                | Actual -> solve ~y ~w:(update_w w) ~ws ~phase xs';;

let solve ~bonus:_ str =
    str
    |> String.to_list
    |> solve
