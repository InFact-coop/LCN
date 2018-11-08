module Components.Nav exposing (navBar)

import Components.StyleHelpers exposing (classes, emptySpan, navLinkFont, navLinkStyle)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


navBar : Model -> String -> Html Msg
navBar model activeLink =
    nav [ classes [ "w-100 mw9 h4 bg-white flex-row justify-between items-center", ifThenElse (model.view /= SplashScreen) "flex flex-row justify-between items-center" "dn" ] ]
        [ a [ href "/", class "pointer pa3" ] [ img [ src "/assets/lcn-logo.png", class "h3" ] [] ]
        , div [ class "dn db-ns" ]
            [ link "/#about" "About" activeLink
            , link "/#list-comments" "Comments" activeLink
            , ifThenElse model.isAdmin (link "/invite-users" "Invite users" activeLink) emptySpan
            , link "/logout" "Log out" activeLink
            ]
        ]


link : String -> String -> String -> Html Msg
link hrefContent textContent activeLink =
    a
        [ classes
            [ "dib mh3"
            , navLinkFont
            , navLinkStyle
            , ifThenElse (hrefContent == activeLink) "active" ""
            ]
        , href hrefContent
        ]
        [ text textContent ]
