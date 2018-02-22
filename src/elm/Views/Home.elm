module Views.Home exposing (..)

import Components.LawCentre exposing (lawCentreList, lawCentreOption)
import Components.StyleHelpers exposing (bodyFont, classes, emptyDiv, inputFont, inputLabelFont)
import Data.LawCentre exposing (decoderLC, stringToLawCentre)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder, andThen)
import Types exposing (..)


homeView : Model -> Bool -> Html Msg
homeView model showLogoutLinks =
    section [ class "flex items-center justify-center vh-100" ]
        [ section [ class "flex items-center justify-between flex-column bg-white pa5-ns pa2 pv4" ]
            [ img [ class "mb4", src "./assets/lcn-logo.png" ] []
            , ifThenElse (showLogoutLinks) loggedOutNotification emptyDiv
            , div [ class "w-100-ns w-90 bb bw1 mb4 pb2 b--pink" ]
                [ label [ for "name", classes [ "mr3", inputLabelFont ] ] [ text "Name:" ]
                , input [ id "name", classes [ inputFont, "bn w-75" ], type_ "text", placeholder "Larry Law", onInput UpdateName ] []
                ]
            , div [ class "w-100-ns w-90 bb bw1 mb4 pb2 b--orange" ]
                [ label [ for "email", classes [ "mr3", inputLabelFont ] ] [ text "Email:" ]
                , input [ id "email", classes [ inputFont, "bn w-75" ], type_ "email", placeholder "larry.law@lawcentres.org" ] []
                ]
            , div [ class "w-100-ns w-90 bb bw1 mb4 pb2 b--blue" ]
                [ label [ for "password", classes [ "mr3", inputLabelFont ] ] [ text "Password:" ]
                , input [ id "password", classes [ inputFont, "bn w-70-ns w-60" ], type_ "password", placeholder "lovethelaw" ] []
                ]
            , div [ class "w-100-ns w-90 bb bw1 mb4 pb2 b--green" ]
                [ label [ for "lawcentre", classes [ "mr3", inputLabelFont ] ] [ text "Law Centre:" ]
                , select [ id "lawcentre", classes [ inputFont, "bn" ], placeholder "Camden", on "change" <| Json.Decode.map UpdateLawCentre targetValueDecoderLC ]
                    (List.map lawCentreOption lawCentreList)
                ]
            , a [ href "#numbers", class "link black dib bw1 f3 br3 ba b--black ph5 pv3 center" ] [ text "Log in" ]
            ]
        ]


loggedOutNotification : Html Msg
loggedOutNotification =
    div [ class "b--pink bw1 pl2 bl mb4" ]
        [ div [ classes [ "w-100-ns w-90 mb2", inputLabelFont ] ] [ text "You are now logged out" ]
        , div [ classes [ "mw6", bodyFont ] ]
            [ text "Why not share your stories on our "
            , a [ href "https://twitter.com/LawCentres", class "link pointer pink" ] [ text "Twitter " ]
            , text "page or on "
            , a [ href "https://www.facebook.com/LawCentres/", class "link pointer pink" ] [ text "Facebook" ]
            , text "? You could also visit the "
            , a [ href "http://www.lawcentres.org.uk/", class "link pointer pink" ] [ text "LCN website " ]
            , text "to see our latest updates"
            ]
        ]


targetValueDecoderLC : Decoder LawCentre
targetValueDecoderLC =
    targetValue
        |> andThen decoderLC
