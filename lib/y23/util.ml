open Batteries

module StringMap = Map.Make(String)
module StringSet = Set.Make(String)
module IntSet = Set.Make(Int)

let to_digit char = Char.code char - 48;;

