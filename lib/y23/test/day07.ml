let solve = Y23.solve 7 ~bonus:false;;
let solve_bonus = Y23.solve 7 ~bonus:true;;

let example =
"32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483";;

let%test "one hand" = solve "AAAAA 1" = 1;;
let%test "two dif kind hands" = solve "AAAAA 3\nAAAAK 5" = 11;;
let%test "two same kind hands" = solve "AAAAK 3\nKAAAA 5" = 11;;
let%test "example" = solve example = 6440;;
let%test "one hand bonus" = solve_bonus "AAAAA 1" = 1;;
let%test "two dif kind hands bonus" = solve_bonus "AAAAA 3\nJJJJK 5" = 11;;

let%test "test joker" = solve_bonus "AAAAK 3\nJJJJK 5" = 13;;
let%test "test joker 2" = solve_bonus "AAAKK 3\nJJKK2 5" = 13;;
let%test "all jokers bonus" = solve_bonus "JJJJJ 2\nKKKKA 3\nAAAJJ 5" = 22;;
let%test "example bonus" = solve_bonus example = 5905;;
