module Components.Nav exposing (navBar)

import Components.StyleHelpers exposing (classes, emptySpan, navLinkFont, navLinkStyle)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


navBar : Model -> Html Msg
navBar model =
    nav [ classes [ "w-100 mw9 h4 bg-white flex-row justify-between items-center", ifThenElse (model.view /= SplashScreen) "flex flex-row justify-between items-center" "dn" ] ]
        [ a [ href "/", class "pointer" ] [ img [ src "/assets/lcn-logo.png", class "h4" ] [] ]
        , div [ class "dn db-ns" ]
            [ a [ classes [ "dib mh3", navLinkFont, navLinkStyle ], href "/#list-comments" ] [ text "Comments" ]
            , ifThenElse model.isAdmin (a [ classes [ "dib mh3", navLinkFont, navLinkStyle ], href "/invite-users" ] [ text "Invite users" ]) emptySpan
            , a [ classes [ "dib mh3", navLinkFont, navLinkStyle ], href "/logout" ] [ text "Log out" ]
            ]
        ]
