let solve = Y23.solve 6 ~bonus:false;;
let solve_bonus = Y23.solve 6 ~bonus:true;;

let example =
"Time:      7  15   30
Distance:  9  40  200";;

let%test "one single val" = solve "Time: 2\nDistance: 0" = 1;;

let%test "two vals" = solve "Time: 3\nDistance: 1" = 2;;

let%test "two games" = solve "Time: 2 3\nDistance: 0 1" = 2;;

let%test "three games" = solve "Time: 2 3 4\nDistance: 0 1 2" = 6;;

let%test "example" = solve example = 288;;

let%test "two fake games" = solve_bonus "Time: 2 3\n Distance: 0 1" = 22;;

let%test "example bonus" = solve_bonus example = 71503;;
