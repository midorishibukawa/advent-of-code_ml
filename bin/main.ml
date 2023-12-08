module C = Core
module D = Dream
module S = Static
module T = Templates
module Y23 = Y2023

let solved = 2;;

let () =
    let nav = T.nav @@ List.init 25 @@ fun x -> (string_of_int @@ x + 1, x + 1 > solved) in
    let loader _root path _request = 
        match Static.read path with 
        | None -> Dream.empty `Not_Found 
        | Some asset -> D.respond asset in
    let handle_htmx ~req body =
        match D.header req "HX-Request" with
        | None   -> D.html @@ T.page ~title:"advent of code" ~nav ~body
        | Some _ -> D.html body in
    D.run ~tls:true
    @@ D.logger 
    @@ D.memory_sessions
    @@ D.router [

        D.get "/static/**" @@ D.static ~loader "";

        D.get "/" (fun req -> 
            handle_htmx ~req
            @@ "");

        D.get "/:day" (fun req ->
            let opt_day = int_of_string_opt @@ D.param req "day" in
            let day () = Lazy.force @@ lazy (Option.get opt_day) in
            if Option.is_some opt_day && day () > 0 && day () <= 2
            then handle_htmx ~req @@ T.form ~endpoint:(D.param req "day") ~req
            else D.html ~status:`Not_Found "");

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
                | _                    -> D.html ~status:`Bad_Request "" in
            match (D.param req "day") with
            | "1" -> handle_form Y2023.d01
            | "2" -> handle_form Y2023.d02
            | _ -> D.html ~status:`Not_Found "");
    ]
