open Batteries

let solved =
    [ Day01.solve 
    ; Day02.solve 
    ; Day03.solve 
    ; Day04.solve
    ];;

let solve n = List.at solved @@ n - 1
