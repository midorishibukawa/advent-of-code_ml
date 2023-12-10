let solve = Y23.solve 4 ~bonus:false;;

let example =
"
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
";;

let%test "no winning" = solve "Card 0: 1 | 2" = 0;;

let%test "one num one win" = solve "Card 1: 1 | 1" = 1;;

let%test "two nums one wine" = solve "Card 1: 1 2 | 1" = 1;;

let%test "two lines" = solve "Card 1: 11 | 11\nCard 2: 13 | 13" = 2;;

let%test "example" = solve example = 13;;
