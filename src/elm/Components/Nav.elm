module Components.Nav exposing (navBar)

import Components.StyleHelpers exposing (classes, navLinkFont, navLinkStyle)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


navBar : Model -> Html Msg
navBar model =
    nav [ class "w-100 mw9 h4 bg-white flex-row justify-between items-center flex" ]
        [ a [ href "/", class "pointer" ] [ img [ src "/assets/lcn-logo.png", class "h4" ] [] ]
        , div [ class "dn db-ns" ]
            [ a [ classes [ "dib mh3", navLinkFont, navLinkStyle ], href "/#add-comment" ] [ text "Add Comment" ]
            , a [ classes [ "dib mh3", navLinkFont, navLinkStyle ], href "/#list-comments" ] [ text "Comments" ]
            , a [ classes [ "dib mh3", navLinkFont, navLinkStyle ], href "/logout" ] [ text "Log out" ]
            ]
        ]
