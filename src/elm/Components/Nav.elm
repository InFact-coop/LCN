module Components.Nav exposing (navBar)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


navBar : Model -> Html Msg
navBar model =
    nav [ class <| "w-100 h4 bg-white flex-row justify-between items-center" ++ toggleNav model.view ]
        [ a [ href "/", class "pointer" ] [ img [ src "/assets/lcn-logo.png", class "h4" ] [] ]
        , div []
            [ a [ class "dib mh3 link black pointer", href "/#numbers" ] [ text "Add?" ]
            , a [ class "dib mh3 link black pointer", href "/#list-comments" ] [ text "Comments" ]
            , a [ class "dib mh3 link black pointer", href "/#logout" ] [ text "Log out" ]
            ]
        ]


toggleNav : View -> String
toggleNav view =
    case view of
        Home ->
            " dn"

        _ ->
            " flex"
