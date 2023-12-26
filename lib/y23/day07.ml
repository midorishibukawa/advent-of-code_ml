open Batteries
open Util

type hand_kind = 
    Five_of_a_kind 
    | Four_of_a_kind 
    | Full_house 
    | Three_of_a_kind 
    | Two_pair 
    | One_pair 
    | High_card;;

type hand = 
    { cs : int list 
    ; kind: hand_kind
    ; bid : int };;

type phase = Hand | Bid;;

let val_of_kind hand_type =
    match hand_type with 
    | Five_of_a_kind    -> 6
    | Four_of_a_kind    -> 5
    | Full_house        -> 4
    | Three_of_a_kind   -> 3
    | Two_pair          -> 2
    | One_pair          -> 1
    | High_card         -> 0;;

let get_kind_from_map ~bonus map =
    let (j, map) = 
        if not bonus 
        then (0, map)
        else 
            try IntMap.extract 1 map 
            with _ -> (0, map) in
    let vals = List.of_enum @@ IntMap.values map in
    let ls = List.length vals in 
    match ls with 
    | 1 -> Five_of_a_kind 
    | 2 -> if List.max vals + j = 4 then Four_of_a_kind else Full_house 
    | 3 -> if List.max vals + j = 3 then Three_of_a_kind else Two_pair 
    | 4 -> One_pair 
    | 0 -> if j > 0 then Five_of_a_kind else High_card
    | _ -> High_card;;

let get_val ~bonus card =
    match Char.uppercase_ascii card with 
    | 'A' -> 14
    | 'K' -> 13
    | 'Q' -> 12
    | 'J' -> if bonus then 1 else 11
    | 'T' -> 10
    | c -> if Char.is_digit c then to_digit c else -1;;

let rec sort_hands_by_cards ps qs =
    match ps, qs with
    | [], _ | _, [] -> 0
    | (p::ps'), (q::qs') -> 
            let cdif = p - q in 
            if cdif != 0 
            then cdif 
            else sort_hands_by_cards ps' qs';;

let sort_hands a b =
    let rdif = val_of_kind a.kind - val_of_kind b.kind in 
    if rdif != 0 
    then rdif 
    else sort_hands_by_cards a.cs b.cs;;

let rec get_hand ?(cs=[]) ?(map=IntMap.empty) ?(bid=0) ?(phase=Hand) ~bonus xs =
    let get_hand = get_hand ~bonus in
    let card () =
        { cs = List.rev cs
        ; kind = get_kind_from_map ~bonus map 
        ; bid = bid } in
    match xs with 
    | [] -> (card (), [])
    | ('\n'::xs') -> (card (), xs')
    | (' '::xs') -> get_hand ~cs ~map ~phase:Bid xs'
    | (x::xs') ->
            match phase with
            | Hand -> 
                    let c = get_val ~bonus x in
                    let map = IntMap.modify_def 0 c (Stdlib.(+) 1) map in
                    get_hand ~cs:(c::cs) ~map xs' 
            | Bid -> get_hand ~cs ~map ~bid:(bid * 10 + to_digit x) ~phase xs'

let rec solve ?(hs=[]) ~bonus xs =
    let solve = solve ~bonus in 
    match xs with
    | [] -> let hs = List.sort sort_hands hs in
            List.fold_lefti (fun acc i h -> acc + (i + 1) * h.bid) 0 hs
    | xs -> let (h, xs') = get_hand ~bonus xs in
            solve ~hs:(h::hs) xs'
    

let solve ~bonus str =
    str 
    |> String.to_list
    |> solve ~bonus
