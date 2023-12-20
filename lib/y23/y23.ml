open Batteries

let solved =
    [ Day01.solve, true ; Day02.solve, true ; Day03.solve, true ; Day04.solve, true ; Day05.solve, false 
    ; Day06.solve, true ; Day07.solve, true ; Day08.solve, false ; Day09.solve, true
    ];;

let solve n = 
    let (f, _ ) = List.at solved @@ n - 1 in 
    f
