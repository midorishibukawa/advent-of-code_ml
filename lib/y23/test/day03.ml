let d03 = Y23.solve 3;;
let solve = d03 ~bonus:false;;

let example =
"
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
";;

let%test "single_number" = solve "1" = 0;;

let%test "one_valid_number" = solve "1*" = 1;;

let%test "two_valid_numbers" = solve "1%2" = 3;;

let%test "two_lines" = solve "1\n#" = 1;;

let%test "alone" = solve "...\n.1.\n..." = 0;;

let%test "one_symbol_two_numbers" = solve "1..\n.@.\n..2" = 3;;

let%test "space_apart" = solve "1.2" = 0;;

let%test "test_example" = solve example = 4361;; 
