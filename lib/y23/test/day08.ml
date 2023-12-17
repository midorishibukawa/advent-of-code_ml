let solve = Y23.solve 8 ~bonus:false;;

let example_a =
"RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)";;

let example_b =
"LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)";;

let%test "example a" = solve example_a = 2;; 

let%test "example b" = solve example_b = 6;; 
