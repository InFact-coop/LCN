module Views.AddStats exposing (..)

import Components.Button exposing (..)
import Components.StyleHelpers exposing (bodyFont, classes, headlineFont)
import Data.LawArea exposing (decoderLawArea, stringToLawArea)
import Helpers exposing (unionTypeToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder, andThen)
import Types exposing (..)


addStatsView : Model -> Html Msg
addStatsView model =
    section
        [ class "flex justify-center pa3-ns pv3" ]
        [ section [ class "w-80-ns w-90" ]
            [ section [ class "mb4" ]
                [ h1 [ classes [ "tl mb3", headlineFont ] ] [ text "Introduction" ]
                , p [ class bodyFont ] [ text "An intro into why LCN want this information etc etc" ]
                ]
            , section [ class "mb4" ]
                [ h1 [ classes [ "tl mb4", headlineFont ] ]
                    [ text "Weekly survey" ]
                , div
                    []
                    [ h2 [ class "mb4 black f3 fw5 b" ]
                        [ text "What is your role?" ]
                    , div [] (roleButtonsList model)
                    ]
                , div [ class "mt4 mb4" ]
                    [ label [ for "lawArea", class "mb4 black f3 fw5 b" ] [ text "What is your primary area of Law?" ]
                    , select [ id "areaOfLaw", class "db f4 mt3 b--light-gray ba bw1 fw2 br4 ph4 pv2 input-reset bg-white", placeholder "Immigration", on "change" <| Json.Decode.map UpdateLawArea targetValueDecoderLawArea ]
                        [ option [ class "f3", value <| unionTypeToString Immigration ] [ text <| unionTypeToString Immigration ]
                        , option [ class "f3", value <| unionTypeToString Family ] [ text <| unionTypeToString Family ]
                        ]
                    ]
                , section [ class "mb4" ]
                    [ h1 [ classes [ "tl mb4", headlineFont ] ]
                        [ text "Your Week" ]
                    , div []
                        [ div
                            [ class "db mb4" ]
                            [ label [ for "peopleSeenWeekly", class "mb4 black f3 fw5 b" ]
                                [ text "How many people have you seen this week?" ]
                            , input [ id "peopleSeenWeekly", type_ "number", class "mt3 db br4 bw1 pa2 f3 ba b--light-gray", size 3, onInput UpdatePeopleSeen ] []
                            ]
                        , div
                            [ class "db mb4" ]
                            [ label [ for "peopleTurnedAwayWeekly", class "mb4 black f3 fw5 b" ]
                                [ text "How many people have you turned away this week?" ]
                            , input [ id "peopleTurnedAwayWeekly", type_ "number", class "mt3 db br4 bw1 pa2 f3 ba b--light-gray", size 3, onInput UpdatePeopleTurnedAway ] []
                            ]
                        ]
                    ]
                , bigColouredButton "green" "Submit" PostStats
                ]
            ]
        ]


roleButtonsList : Model -> List (Html Msg)
roleButtonsList model =
    case model.role of
        CaseWorker ->
            [ colouredButton ("pink grow") CaseWorker
            , colouredButton ("green o-30 shrink") Management
            , colouredButton ("orange o-30 shrink") Triage
            ]

        Management ->
            [ colouredButton ("pink o-30 shrink") CaseWorker
            , colouredButton ("green grow") Management
            , colouredButton ("orange o-30 shrink") Triage
            ]

        Triage ->
            [ colouredButton ("pink o-30 shrink") CaseWorker
            , colouredButton ("green o-30 shrink") Management
            , colouredButton ("orange grow") Triage
            ]

        NoRole ->
            [ colouredButton ("pink o-30 shrink") CaseWorker
            , colouredButton ("green o-30 shrink") Management
            , colouredButton ("orange o-30 shrink") Triage
            ]


targetValueDecoderLawArea : Decoder LawArea
targetValueDecoderLawArea =
    targetValue
        |> andThen decoderLawArea
