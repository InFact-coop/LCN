module Components.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


navbar : Model -> FormView -> Html Msg
navbar model location =
    let
        bgColour =
            navBarColour location
    in
    case model.route of
        WorkerViewRoute ->
            ul [ class ("dib ma0 w-100 pa2 " ++ bgColour) ] <|
                [ navbarLink <| ( "home", "Home" ) ]
                    ++ navbarMsgContent
                    ++ [ li [ class "list dib ma3 f3 link dim white b" ] [ text <| toString model.formView ] ]

        _ ->
            ul [ class "dib ma0 bg-green w-100 pa2" ] <|
                [ navbarLink <| ( "home", "Home" ) ]
                    -- ++ navbarMsgContent
                    ++ [ li [ class "list dib ma3 f3 link dim white b" ] [ text <| toString model.route ] ]


navbarLink : ( String, String ) -> Html Msg
navbarLink ( linkStr, name ) =
    li [ class "list dib ma3" ] [ a [ class "link dim white b", href ("/#" ++ linkStr) ] [ text name ] ]


navbarMsg : ( String, FormView ) -> Html Msg
navbarMsg ( name, newView ) =
    li [ class "list dib ma3 link pointer dim white b", onClick <| UpdateFormView newView ] [ text name ]


navbarMsgContent : List (Html Msg)
navbarMsgContent =
    List.map navbarMsg [ ( "Dashboard", Dashboard ), ( "Success", Success ), ( "Bug", Bug ), ( "Help", Help ), ( "Suggest", Suggest ) ]


navBarColour : FormView -> String
navBarColour location =
    case location of
        Success ->
            "bg-green"

        Bug ->
            "bg-blue"

        Help ->
            "bg-red"

        Suggest ->
            "bg-yellow"

        _ ->
            "bg-black"
