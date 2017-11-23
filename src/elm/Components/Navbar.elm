module Components.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


navbar : Model -> Html Msg
navbar model =
    let
        bgColour =
            navBarColour model.formView
    in
    case model.route of
        WorkerViewRoute ->
            ul [ class ("dib ma0 w-100 pa2 " ++ bgColour) ] <|
                -- Home link
                [ navbarLink <| ( "home", "Home" ) ]
                    -- Little links
                    ++ navbarMsgContent
                    -- Name of current page
                    ++ [ li [ class "list dib ma3 f3 link dim white b" ] [ text <| toString model.formView ] ]

        _ ->
            ul [ class "dib ma0 bg-green w-100 pa2" ] <|
                [ navbarLink <| ( "home", "Home" ) ]
                    ++ [ li [ class "list dib ma3 f3 link dim white b" ] [ text <| toString model.route ] ]



-- set up Navigation links here:


navbarLink : ( String, String ) -> Html Msg
navbarLink ( linkStr, name ) =
    li [ class "list dib ma3" ] [ a [ class "link dim white b", href ("/#" ++ linkStr) ] [ text name ] ]



-- set up our own form change links here:


navbarMsgContent : List (Html Msg)
navbarMsgContent =
    List.map navbarMsg [ ( "Dashboard", Dashboard ), ( "Made My Day", MadeMyDay ), ( "Bug Bear", Bug ), ( "I-Spy", ISpy ), ( "Snapshot", Snapshot ) ]



-- set up each individual link:


navbarMsg : ( String, FormView ) -> Html Msg
navbarMsg ( name, newView ) =
    li [ class "list dib ma3 link pointer dim white b", onClick <| UpdateFormView newView ] [ text name ]



-- set colour


navBarColour : FormView -> String
navBarColour location =
    case location of
        MadeMyDay ->
            "bg-green"

        Bug ->
            "bg-blue"

        ISpy ->
            "bg-red"

        Snapshot ->
            "bg-yellow"

        _ ->
            "bg-black"
