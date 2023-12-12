let solve = Y23.solve 4 ~bonus:false;;
let solve_bonus = Y23.solve 4 ~bonus:true;;

let example =
"
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
";;

let%test "empty" = solve "" = 0;;

let%test "no winning" = solve "Card 0: 1 | 2" = 0;;

let%test "1 num 1 win" = solve "Card 1: 1 | 1" = 1;;

let%test "2 nums 1 win" = solve "Card 1: 1 2 | 1" = 1;;

let%test "2 lines" = solve "Card 1: 11 | 11\nCard 2: 13 | 13" = 2;;

let%test "multiple empty" = solve "\n\n\n\n" = 0;;

let%test "example" = solve example = 13;;

let%test "empty bonus" = solve_bonus "" = 0;;

let%test "no winning bonus" = solve_bonus "Card 0: 1 | 2" =  1;;

let%test "2 lines no win bonus" = solve_bonus "Card 0: 1 | 2\nCard 1: 2 | 3" = 2;;

let%test "2 lines 1 win on 1st bonus" = solve_bonus "Card 1: 1 | 1 \nCard 2: 0 | 2" = 3;;

let%test "3 lines 2 wins on 1st 1 win on 2nd bonus" = solve_bonus "Card 1: 1 2 | 1 2\nCard 2: 3 | 3\nCard3: 0 | 99" = 7;;

let%test "multiple empty bonus" = solve_bonus "\n\n\n\n" = 0;;

let%test "example bonus" = solve_bonus example = 30;;
