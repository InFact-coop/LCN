module Components.Nav exposing (navBar)

import Html exposing (..)
import Html.Attributes exposing (..)


navBar : Html msg
navBar =
    nav [ class "w-100 h4 bg-white flex flex-row justify-between items-center" ]
        [ img [ src "/assets/lcn-logo.png", class "h4" ] []
        , div []
            [ a [ class "dib mh3 link", href "/#numbers" ] [ text "Add?" ]
            , a [ class "dib mh3 link", href "/#list-comments" ] [ text "Comments" ]
            , a [ class "dib mh3 link", href "/#logout" ] [ text "Log out" ]
            ]
        ]
