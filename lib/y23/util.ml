open Batteries

module StringMap = Map.Make(String)
module IntMap = Map.Make(Int)
module StringSet = Set.Make(String)
module IntSet = Set.Make(Int)

let to_digit char = Char.code char - 48;;

let rec get_num ?(n=0) ?(neg=false) xs =
    match xs with
    | [] -> (n * (if neg then -1 else 1), xs)
    | ('-'::xs') -> get_num ~neg:true xs'
    | (x::xs') ->
        if Char.is_digit x
        then get_num ~n:(n * 10 + (to_digit x)) ~neg xs'
        else (n, xs);; 

