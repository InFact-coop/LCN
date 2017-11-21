module Routes.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


navbar : Model -> Html Msg
navbar model =
    case model.route of
        WorkerView ->
            ul [ class "dib ma0 bg-green w-100 pa2" ] <|
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


navbarMsg : ( String, Msg ) -> Html Msg
navbarMsg ( name, updateMsg ) =
    li [ class "list dib ma3 link dim white b", onClick updateMsg ] [ text name ]


navbarMsgContent : List (Html Msg)
navbarMsgContent =
    List.map navbarMsg [ ( "Dashboard", UpdateFormView Dashboard ), ( "Success", UpdateFormView Success ), ( "Bug", UpdateFormView Bug ), ( "Help", UpdateFormView Help ), ( "Suggest", UpdateFormView Suggest ), ( "Overview", UpdateFormView Overview ) ]
