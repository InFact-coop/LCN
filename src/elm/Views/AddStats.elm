module Views.AddStats exposing (addStatsView, introText)

import Components.Button exposing (..)
import Components.StatsThisWeek exposing (statsThisWeek)
import Components.StyleHelpers exposing (bodyFont, checkboxFont, classes, displayElement, emptySpan, headlineFont, promptFont)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


submitButton : Model -> Html Msg
submitButton model =
    case model.postStatsStatus of
        UserConfirmation ->
            bigColouredButton True "green" "Confirm" PostStats

        Loading ->
            bigColouredButton True
                "gray"
                "..."
                NoOp

        ResponseFailure ->
            div [ class "flex flex-column items-center" ]
                [ div [ class "f3 fw5 red mb3" ] [ text "Oops, something didn't work" ]
                , bigColouredButton True
                    "red"
                    "Try again"
                    PostStats
                ]

        NotAsked ->
            bigColouredButton True "green" "Submit" ConfirmStats

        ResponseSuccess ->
            div [ class "flex flex-column items-center" ]
                [ div [ class "f3 fw5 green mb3" ] [ text "You have successfully sent your stats." ]
                , div [ class "f3 fw5 green b" ] [ text "See you next week!" ]
                ]


editButton : Model -> Html Msg
editButton model =
    bigColouredButton True "orange" "Go back" EditStats


callsToAction : Model -> Html Msg
callsToAction model =
    div [ class "flex justify-center" ]
        [ ifThenElse (model.postStatsStatus == UserConfirmation) (editButton model) emptySpan
        , submitButton model
        ]


addStatsView : Model -> Html Msg
addStatsView model =
    section
        [ classes [ "flex justify-center pa3-ns pv3", ifThenElse model.displayStatsModal "disableButton" "" ] ]
        [ section [ class "w-80-ns w-90" ]
            [ section [ class "mb4" ]
                [ h1 [ classes [ "tl mb3", headlineFont ] ] [ text "Introduction" ]
                , p [ class bodyFont ]
                    introText
                ]
            , statsThisWeek model
            , section [ class "mb4" ]
                [ callsToAction
                    model
                ]
            ]
        ]


introText : List (Html Msg)
introText =
    [ text "Please ", span [ class "fw5" ] [ text "tell us a little about your week " ], text "since the last time you checked in. You can ", span [ class "fw5" ] [ text "type" ], text ", ", span [ class "fw5" ] [ text "use the spinner buttons" ], text ", or ", span [ class "fw5" ] [ text " use the arrows on your keyboard " ], text "to provide your answer." ]
