module Components.StatsModal exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Components.StyleHelpers exposing (displayElement, classes)
import Components.Button exposing (modalButton)
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
                [ "modal fixed f3 ph5 pb4 pt5 bg-white br2 w-70 z-2 center tc"
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
                , h2 [ classes [ "f2", "fw3", "mt3", "mb5" ] ]
                    [ text "We've now seen "
                    , span
                        [ classes
                            [ "pink"
                            , "b"
                            , displayElement <| model.listStatsStatus == ResponseSuccess
                            ]
                        ]
                        [ text <| toString model.peopleSeenWeeklyAll ++ " people" ]
                    , text " this week!"
                    ]
                , h1 [ classes [ "f2" ] ]
                    [ text "What would you like to do now?" ]
                , section
                    [ classes [ "action-buttons", "mt3" ] ]
                    [ modalButton "Add Comment" "#add-comment"
                    , modalButton "See comments" "#list-comments"
                    , modalButton "Log out" "#logout"
                    ]
                ]
            ]
