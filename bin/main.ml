module D = Dream
module S = Static
module T = Templates
open Batteries

let to_class cs = "class=" ^ String.join " " cs;;

let () =
    let nav = 
        (1--25) 
        |> Enum.map (fun x -> (string_of_int x, to_class @@ if x <= List.length Y23.solved then ["solved"] else [] )) 
        |> List.of_enum 
        |> T.nav in
    let handle_htmx ~req body =
        match D.header req "HX-Request" with
        | None   -> D.html @@ T.page ~title:"advent of code" ~nav ~body
        | Some _ -> D.html body in
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

        D.get "/" (fun req -> 
            handle_htmx ~req
            @@ "");

        D.get "/:day" (fun req ->
            let day = D.param req "day" in 
            try 
                let day' = int_of_string day - 1 in 
                if day' >= 0 && day' < List.length Y23.solved 
                then handle_htmx ~req @@ T.form ~endpoint:day ~req 
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
                            |> D.html
                | _ -> D.html ~status:`Bad_Request "" in
            let day = D.param req "day" in 
            try
                day 
                |> int_of_string
                |> Y23.solve
                |> handle_form
            with _ -> D.html ~status:`Not_Found "");
    ]
