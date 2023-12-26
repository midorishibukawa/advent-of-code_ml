let solve = Y23.solve 9 ~bonus:false;;
let solve_bonus = Y23.solve 9 ~bonus:true;;

let example =
"0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45";;

let%test "one line no dif" = solve "1 1 1 1" = 1;;
let%test "two lines no dif" = solve "1 1 1 1\n2 2 2" = 3;;
let%test "one line arithmetic" = solve "0 2 4 6" = 8;;
let%test "two lines arithmetic" = solve "3 3 4 6 9 13\n0 1 2 3" = 22;;
let%test "negative numbers" = solve "0 -1 -2 -3 -4" = (-5);;
let%test "example" = solve example = 114;;

let%test "one line no dif bonus" = solve_bonus "1 1 1 1" = 1;;
let%test "one line arithmetic bonus" = solve_bonus "0 2 4 6" = -2;;
let%test "two lines arithmetic bonus" = solve_bonus "3 3 4 6 9 13\n0 1 2 3" == 3;;
let%test "negative numbers bonus" = solve_bonus "0 -1 -2 -3 -4" = 1;;
let%test "example bonus" = solve_bonus example = 2;;
