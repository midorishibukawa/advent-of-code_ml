module D = Dream
module S = Static
module T = Templates
open Batteries

let () =
    let get_solved_bonus day =
        if day > List.length Y23.solved
        then (false, false)
        else let (_, is_bonus) = List.at Y23.solved (day - 1) in (true, is_bonus) in
    let nav = 
        (1--25) 
        |> Enum.map (fun x ->
                let (is_solved, is_bonus) = get_solved_bonus x in
                (string_of_int x, is_solved, is_bonus)) 
        |> List.of_enum 
        |> T.nav in
    let handle_htmx ~req body =
        match D.header req "HX-Request" with
        | None   -> Dream_html.respond @@ T.page ~title:"advent of code" ~nav body
        | Some _ -> Dream_html.respond @@ body in
    D.run ~port:8080 ~interface:"0.0.0.0"
    @@ D.logger 
    @@ D.memory_sessions
    @@ D.router [

        D.get "/static/**" 
            @@ D.static 
            ~loader:(fun _root path _req -> 
                match Static.read path with 
                | None -> Dream.empty `Not_Found 
                | Some asset -> D.respond asset)
            "";

        D.get "/" (fun req -> handle_htmx ~req @@ Dream_html.HTML.main [] []);

        D.get "/:day" (fun req ->
            let day = D.param req "day" in 
            try 
                let day' = int_of_string day - 1 in 
                if day' >= 0 && day' < List.length Y23.solved 
                then let (_, bonus) = get_solved_bonus (day' + 1) in
                    handle_htmx ~req @@ T.form ~endpoint:day ~bonus ~req
                else raise Not_found 
            with _ -> D.html ~status:`Not_Found "");

        D.post "/:day" (fun req ->
            let handle_form f =
                match%lwt D.form req with
                | `Ok [ "bonus", bonus
                      ; "input", input ] -> 
                            input 
                            |> f ~bonus:(bonus = "1") 
                            |> string_of_int
                            |> T.p
                            |> Dream_html.respond
                | _ -> D.html ~status:`Bad_Request "" in
            let day = D.param req "day" in 
            try
                day 
                |> int_of_string
                |> Y23.solve
                |> handle_form
            with _ -> D.html ~status:`Not_Found "");
    ]
