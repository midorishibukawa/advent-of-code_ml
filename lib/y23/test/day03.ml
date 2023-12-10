let d03 = Y23.solve 3;;
let solve = d03 ~bonus:false;;
let solve_bonus = d03 ~bonus:true;;

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

let print f x y =
    let res = f x in 
    let () = print_int res in
    let () = print_newline () in
    res == y;;


(* p1 *)
let%test "single_number" = solve "1" = 0;;

let%test "one_valid_number" = solve "1*" = 1;;

let%test "two_valid_numbers" = solve "1%2" = 3;;

let%test "two_lines" = solve "1\n#" = 1;;

let%test "alone" = solve "...\n.1.\n..." = 0;;

let%test "one_symbol_two_numbers" = solve "1..\n.@.\n..2" = 3;;

let%test "space_apart" = solve "1.2" = 0;;

let%test "test_example" = solve example = 4361;; 

(* p2 *)

let%test "single_number_bonus" = solve_bonus "1" = 0;;

let%test "one *" = solve_bonus "1*" = 0;;

let%test "one gear one line" = solve_bonus "2*3" = 6;;

let%test "one gear one line two digit nums" = solve_bonus "11*17" = 187;;

let%test "diagonal nums" = solve_bonus "11...\n..*..\n...17" = 187;;

let%test "two gears" = solve_bonus "1*2.3\n....*\n....5" = 17;;

let%test "two gears sharing num" = solve_bonus "1*2..\n..*..\n..3.." = 8;;

let%test "test_example_bonus" = solve_bonus example = 467835;;

