open Batteries

module StringMap = Map.Make(String)
module StringSet = Set.Make(String)

let to_digit char = Char.code char - 48;;
