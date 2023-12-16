let solve = Y23.solve 6 ~bonus:false;;

let example =
"Time:      7  15   30
Distance:  9  40  200";;

let%test "one single val" = solve "Time: 2\nDistance: 0" = 1;;

let%test "two vals" = solve "Time: 3\nDistance: 1" = 2;;

let%test "two games" = solve "Time: 2 3\nDistance: 0 1" = 2;;

let%test "three games" = solve "Time: 2 3 4\nDistance: 0 1 2" = 6;;

let%test "example" = solve example = 288;;
