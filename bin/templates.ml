open Dream_html 
open HTML 

let page ~title:title_txt ~nav:nav_content html_body =
    html [ lang "en" ] 
        [ head []
            [ title [] title_txt 
            ; meta  [ charset "UTF-8" ] 
            ; meta  [ http_equiv `x_ua_compatible ; content "ID=edge" ]
            ; meta  [ name "viewport" ; content "width=device-width, initial-scale=1.0" ]
            ; link  [ rel "stylesheet" ; href "static/style.css" ]
            ; script    [ src "https://unpkg.com/htmx.org@1.9.2" 
                        ; integrity "sha384-L6OqL9pRWyyFU3+/bjdSri+iIphTN/bvYyM37tICVyOJkWZLpP2vGn6VUEXgzg6h"
                        ; crossorigin `anonymous ] ""]
        ; body []
            [ h1 [] [ txt title_txt ]
            ; nav_content
            ; main [] [html_body] ] ] ;;

let nav days =
    let open Hx in
    let get_class is_solved is_bonus =
        if not is_solved 
        then ""
        else let c = "solved" in
        if is_bonus 
        then c ^ " bonus"
        else c in
    nav [] @@
    List.map 
    (fun (day, is_solved, is_bonus) -> 
        a   [ href "%s" day
            ; class_ "%s" @@ get_class is_solved is_bonus 
            ; boost true 
            ; target "main" ] 
            [ txt "%s" @@ day ])
    days;;

let p ctt = p [] [ txt "%s" ctt ]

let form ~endpoint ~bonus ~req =
    let bonus_input_attrs = [ type_ "radio" ; id "bonus" ; name "bonus" ; value "1"] in
    let open Hx in
    form
        [ post "%s" endpoint
        ; target "main" 
        ; action "%s" endpoint 
        ; method_ `POST ]
        [ csrf_tag req
        ; label [ for_ "input" ] [ txt "%s" "input" ]
        ; textarea [ id "input" ; name "input" ] ""
        ; section [ id "type" ] 
            [ input [ type_ "radio" ; id "simple" ; name "bonus" ; value "0" ; checked ]
            ; label [ for_ "simple" ] [ txt "%s" "simple" ]
            ; input @@ if not bonus then disabled::bonus_input_attrs else bonus_input_attrs
            ; label [ for_ "bonus" ] [ txt "%s" "bonus" ] ] 
        ; button [ type_ "submit" ] [ txt "%s" "submit" ] ];;
