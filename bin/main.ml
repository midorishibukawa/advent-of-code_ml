module D = Dream
module T = Templates
module Y23 = Y2023

let () =
    let days_nav = T.nav @@ List.init 31 @@ fun x -> string_of_int @@ x + 1 in
    let handle_htmx ~req body =
        match D.header req "HX-Request" with
        | None   -> D.html @@ T.page ~title:"advent of code" ~nav:days_nav ~body
        | Some _ -> D.html body in
    D.run ~tls:true
    @@ D.logger 
    @@ D.memory_sessions
    @@ D.router [

        D.get "/static/**" @@ D.static "./static";

        D.get "/" (fun req -> 
            handle_htmx ~req
            @@ "");

        D.get "/:day" (fun req ->
            handle_htmx ~req
            @@ T.form ~endpoint:(D.param req "day") ~req);

        D.post "/:day" (fun req ->
            let handle_form =
                match%lwt D.form req with
                | `Ok [ "input", input] -> input |> Y2023.D01.solve |> T.p |> D.html
                | _                    -> D.html ~status:`Bad_Request @@ "" in
            match (D.param req "day") with
            | "1" -> handle_form
            | _ -> handle_htmx ~req @@ "");
    ]
