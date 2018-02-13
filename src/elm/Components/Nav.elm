module Components.Nav exposing (navBar)

import Html exposing (..)
import Html.Attributes exposing (..)


navBar : Html msg
navBar =
    nav [ class "w-100 h4 bg-white flex flex-row justify-between items-center" ]
        [ img [ src "/assets/lcn-logo.png", class "h4" ] []
        , div []
            [ a [ class "dib mh3" ] [ text "Add?" ]
            , a [ class "dib mh3" ] [ text "Comments" ]
            , a [ class "dib mh3" ] [ text "Log out" ]
            ]
        ]
