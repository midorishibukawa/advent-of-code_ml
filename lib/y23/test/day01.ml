let d01 = Y23.solve 1
let solve = d01 ~bonus:false;;
let solve_bonus = d01 ~bonus:true;;

let example_a =
"1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet";;

let example_b =
"two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen"

(* p1 *)

let%test "empty_string" = solve "" = 0;;

let%test "single_number" = solve "1" = 11;;

let%test "two_numbers" = solve "12" = 12;;

let%test "three_numbers" = solve "123" = 13;;

let%test "with_text" = solve "1abc4" = 14;;

let%test "with_padding" = solve "    1a3c5    " = 15;;

let%test "two_lines" = solve "ab1cd2ef3gh\n4ij5kl6mn7" = 60;;

let%test "example" = solve example_a = 142;;

(* p2 *)

let%test "empty_string_bonus" = solve_bonus "" = 0;;

let%test "single_number_bonus" = solve_bonus "one" = 11;;

let%test "digit_spelled_bonus" = solve_bonus "1two" = 12;;

let%test "spelled_spelled_bonus" = solve_bonus "onethree" = 13;;

let%test "spelled_digit_bonus" = solve_bonus "one4" = 14;;

let%test "with_text_bonus" = solve_bonus "oneabcfive" = 15;;

let%test "three_numbers_bonus" = solve_bonus "onetwosix" = 16;;

let%test "with_padding_bonus" = solve_bonus "    onea3cseven    " = 17;;

let%test "two_lines_bonus" = solve_bonus "abonecd2efthreegh\nfourij5kl6mnseven" = 60;;

let%test "example_bonus" = solve_bonus example_b = 281;;
