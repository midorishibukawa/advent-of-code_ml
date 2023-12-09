let solve = Y2023.d03 ~bonus:false;;

let example =
"467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..";;

let%test "single_number" = solve "1" = 0;;

let%test "test_example" = solve "" = 0;; 
