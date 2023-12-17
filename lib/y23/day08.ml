open Batteries 
open Util

type side = Left | Right

type node = 
    { left: string 
    ; right: string };;

let rec get_seq ?(seq=[]) xs =
    match xs with 
    | [] -> (List.rev seq, [])
    | ('\n'::'\n'::xs') -> (List.rev seq, xs')
    | ('L'::xs') -> get_seq ~seq:(Left::seq) xs'
    | ('R'::xs') -> get_seq ~seq:(Right::seq) xs'
    | (_::xs') -> get_seq ~seq xs';;

let rec walk ?(i=0) ~seq ~map k =
    let side = List.at seq (Int.rem i (List.length seq)) in
    let node = StringMap.find k map in
    let res n = 
        if n = "ZZZ" 
        then i + 1 
        else walk ~i:(i + 1) ~seq ~map n in
    match side with
    | Left -> res node.left 
    | Right -> res node.right;; 

let rec get_key ?(k="") xs =
    match xs with 
    | [] -> (k, [])
    | (' '::'='::' '::'('::xs') | (','::' '::xs') | (')'::'\n'::xs') -> (k, xs')
    | (x::xs') -> get_key ~k:(k ^ Char.escaped x) xs'

let rec solve ?(map=StringMap.empty) ~seq ~bonus xs =
    let solve = solve ~seq ~bonus in
    match xs with 
    | [] -> walk ~seq ~map "AAA"
    | xs -> let (k, xs) = get_key xs in
            let (l, xs) = get_key xs in 
            let (r, xs) = get_key xs in
            let map = StringMap.add k { left = l ; right = r } map in
            solve ~map xs;; 

let solve ~bonus str = 
    let xs = String.to_list str in
    let (seq, xs') = get_seq xs in 
    solve ~bonus ~seq xs'
