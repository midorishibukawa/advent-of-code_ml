let solve = Y23.solve 7 ~bonus:false;;

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
