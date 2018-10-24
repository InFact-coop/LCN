module Components.StatsModal exposing (modalBackground, statsModal)

import Components.Button exposing (modalButton)
import Components.StyleHelpers exposing (classes, displayElement)
import Helpers exposing (prettifyNumber)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


statsModal : Model -> Html Msg
statsModal model =
    let
        name =
            if model.name /= "" then
                ", " ++ model.name

            else
                ""
    in
    section
        [ classes
            [ "modal fixed f3 ph5-ns ph4 pb4 pt5 bg-white br2 w-70-ns w-90 z-3 center tc"
            , displayElement model.displayStatsModal
            ]
        ]
        [ img
            [ src "assets/tick.svg"
            , classes
                [ "icon-above"
                , "h4"
                , "w4"
                , "absolute"
                ]
            , alt "Success"
            ]
            []
        , section [ classes [ "success" ] ]
            [ h1 [ classes [ "f2", "mb4", "mt3" ] ] [ text <| "Thank you" ++ name ++ "!" ]
            , h2 [ classes [ "f2", "fw3", "mt3" ] ]
                [ text "With your help," ]
            , h2 [ classes [ "f2", "fw3", "mt3", "mb4" ] ]
                [ text "we've seen "
                , span
                    [ classes
                        [ "pink"
                        , "b"
                        , displayElement <| model.listStatsStatus == ResponseSuccess
                        ]
                    ]
                    [ text <| prettifyNumber model.peopleSeenWeeklyAll ++ " people" ]
                , text " this week!"
                ]
            , h1 [ classes [ "f2" ] ]
                [ text "What would you like to do now?" ]
            , section
                [ classes [ "action-buttons", "mt4-ns", "mt3" ] ]
                [ modalButton "See Comments" "#list-comments"
                , modalButton "Log out" "#logout"
                ]
            ]
        ]


modalBackground : Model -> Html Msg
modalBackground model =
    div
        [ classes
            [ "w-100"
            , "h-100"
            , "fixed"
            , "bg-black"
            , "o-70"
            , "z-2"
            , "absolute"
            , displayElement model.displayStatsModal
            ]
        ]
        []
