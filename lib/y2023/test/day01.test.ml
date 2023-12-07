open Core

let d01a = Y2023.d01 ~bonus:false;;
let d01b = Y2023.d01 ~bonus:true;;

(* original question *)

let%test "empty_string" = d01a "" = 0;;

let%test "single_number" = d01a "1" = 11;;

let%test "two_numbers" = d01a "12" = 12;;

let%test "three_numbers" = d01a "123" = 13;;

let%test "with_text" = d01a "1abc4" = 14;;

let%test "with_padding" = d01a "    1a3c5    " = 15;;

let%test "two_lines" = d01a "ab1cd2ef3gh\n4ij5kl6mn7" = 60;;

let%test "example" =
    let input = "1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet" in 
    d01a input = 142

(* bonus question *)

let%test "empty_string_bonus" = d01b "" = 0;;

let%test "single_number_bonus" = d01b "one" = 11;;

let%test "digit_spelled_bonus" = d01b "1two" = 12;;

let%test "spelled_spelled_bonus" = d01b "onethree" = 13;;

let%test "spelled_digit_bonus" = d01b "one4" = 14;;

let%test "with_text_bonus" = d01b "oneabcfive" = 15;;

let%test "three_numbers_bonus" = d01b "onetwosix" = 16;;

let%test "with_padding_bonus" = d01b "    onea3cseven    " = 17;;

let%test "two_lines_bonus" = d01b "abonecd2efthreegh\nfourij5kl6mnseven" = 60;;

let%test "example_bonus" =
    let input = "two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\n7pqrstsixteen" in
    d01b input = 281
