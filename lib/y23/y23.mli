val solved : ((bonus:bool -> string -> int) * bool) list
(** [Y23.solved] returns a list of every solution implemented so far *)

val solve : int -> bonus:bool -> string -> int
(** [Y23.solve day] receives an integer for the day 
    and returns the function that solves that day's challenge. 
    
    @raise Invalid_argument if no solution is found.*)
