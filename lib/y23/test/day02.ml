let d02 = Y23.solve 2;;
let solve = d02 ~bonus:false;;
let solve_bonus = d02 ~bonus:true;;

let example =
"Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green";;

(* p1 *)

let%test "empty" = solve "" = 0;;

let%test "one_line_ok" = solve "Game 99: 1 red, 2 blue, 3 green" = 99;;

let%test "one_line_multi_ok" = solve "Game 99: 1 red, 2 blue, 3 green; 4 red, 5 blue, 6 green" = 99;;

let%test "one_line_nok" = solve "Game 99: 20 red; 20 blue; 20 green" = 0;;

let%test "one_line_multi_nok" = solve "Game 99: 1 red, 2 blue, 3 green; 20 red, 5 blue, 6 green" = 0;;

let%test "multi_line_ok_ok" = solve "Game 17: 1 red, 2 blue, 3 green\nGame 19: 11 red, 12 blue, 13 green" = 36;;

let%test "multi_line_ok_nok" = solve "Game 17: 1 red, 2 blue, 3 green\nGame 19: 11 red, 99 blue, 13 green" = 17;;

let%test "example" = solve example = 8;;

(* p2 *)

let%test "empty_bonus" = solve_bonus "" = 0;;

let%test "one_line_one_game" = solve_bonus "Game 1: 1 red, 2 blue, 3 green" = 6;;

let%test "one_line_multi_game" = 
    let input = "Game 1: 1 red, 2 blue, 3 green; 2 red, 3 blue, 4 green" in 
    solve_bonus input = 24;;

let%test "multi_line_multi_game" = 
    let input = "Game 1: 1 red, 2 blue, 3 green; 2 red, 3 blue, 4 green\nGame 2: 5 red, 6 blue, 7 green" in 
    solve_bonus input = 234;;

let%test "example_bonus" = solve_bonus example = 2286;;
