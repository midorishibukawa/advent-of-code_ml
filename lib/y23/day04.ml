open Batteries
open Util

type phase = Skip | Winning | Actual

let rec update_qs ?(acc=[]) ~n p qs =
    let update_qs = update_qs ~n in
    match qs with 
    | [] -> if p <= 0
            then List.rev acc
            else update_qs ~acc:(n + 1::acc) (p - 1) []
    | (q::qs') -> update_qs ~acc:((q + if p <= 0 then 0 else n)::acc) (p - 1) qs';;

let rec solve ?(y=0) ?(w=(-1)) ?(ws=IntSet.empty) ?(qs=[]) ?(num=0) ?(phase=Skip) ~bonus xs =
    let solve = solve ~bonus in
    let update_w w = w + if IntSet.mem num ws then 1 else 0 in
    let get_points w = 
        let w = update_w w in 
        if w < 0 then 0 else Int.pow 2 w in 
    let get_card_qty qs =
        if not bonus || phase != Actual 
        then (0, []) 
        else if List.length qs = 0 
        then (1, []) 
        else (List.hd qs, List.tl qs) in
    let get_dy w qs =
        if not bonus 
        then get_points w
        else let (qty, _) = get_card_qty qs in
        qty in
    match xs with 
    | [] -> y + get_dy w qs
    | (':'::xs')  -> solve ~y ~qs ~phase:Winning xs'
    | ('|'::xs')  -> solve ~y ~ws ~qs ~phase:Actual xs'
    | ('\n'::xs') -> 
            let qs' = 
                if not bonus 
                then [] 
                else let (n, qs') = get_card_qty qs in 
                update_qs ~n (update_w w + 1) qs' in
            solve ~y:(y + get_dy w qs) ~qs:qs' ~phase:Skip xs'
    | (x::xs') -> 
            if Char.is_digit x 
            then let (num, xs') = get_num xs in
                solve ~y ~w ~ws ~num ~qs ~phase xs' 
            else 
                match phase with 
                | Skip -> solve ~y ~qs ~phase xs'
                | Winning -> 
                        let ws = if num = 0 then ws else IntSet.add num ws in
                        solve ~y ~ws ~qs ~phase xs'
                | Actual -> solve ~y ~w:(update_w w) ~ws ~qs ~phase xs';;

let solve ~bonus str =
    str
    |> String.to_list
    |> solve ~bonus
