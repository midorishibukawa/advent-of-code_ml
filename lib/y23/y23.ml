open Batteries

let solved =
    [ Day01.solve 
    ; Day02.solve 
    ; Day03.solve 
    ; Day04.solve
    ; Day05.solve
    ; Day06.solve
    ; Day07.solve
    ; Day08.solve
    ];;

let solve n = List.at solved @@ n - 1
