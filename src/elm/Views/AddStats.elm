module Views.AddStats exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder, andThen)
import Types exposing (..)
import Components.Button exposing (..)


addStatsView : Model -> Html Msg
addStatsView model =
    section
        [ class "flex justify-center h-100 pa3" ]
        [ section [ class "w-80" ]
            [ section [ class "mb5" ]
                [ h1 [ class "tl f2 fw5 black mb3" ] [ text "Introduction" ]
                , p [ class "fw3 f4" ] [ text "An intro into why LCN want this information etc etc" ]
                ]
            , section [ class "mb5" ]
                [ h1 [ class "tl f2 black mb4" ]
                    [ text "Weekly survey" ]
                , div
                    [ class "pl4" ]
                    [ h2 [ class "mb4 black f3 fw5 b" ]
                        [ text "What is your role?" ]
                    , div
                        []
                        (roleButtonsList model)
                    ]
                , div [ class "pl4 mt4 mb5" ]
                    [ label [ for "lawArea", class "mb4 black f3 fw5 b" ] [ text "What is your primary area of Law?" ]
                    , select [ id "areaOfLaw", class "db f4 mt3 b--light-gray ba bw1 fw2 br4 pa2", placeholder "Immigration", on "change" <| Json.Decode.map UpdateLawArea targetValueDecoderLawArea ]
                        [ option [ class "f3", value <| toString Immigration ] [ text <| toString Immigration ]
                        , option [ class "f3", value <| toString Criminal ] [ text <| toString Criminal ]
                        ]
                    ]
                , section [ class "mb5" ]
                    [ h1 [ class "tl f2 black mb4" ]
                        [ text "Your Week" ]
                    , div [ class "pl4" ]
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


targetValueDecoderLawArea : Decoder LawArea
targetValueDecoderLawArea =
    targetValue
        |> andThen decoderLawArea


decoderLawArea : String -> Decoder LawArea
decoderLawArea val =
    case val of
        "Criminal" ->
            Json.Decode.succeed Criminal

        "Immigration" ->
            Json.Decode.succeed Immigration

        _ ->
            Json.Decode.succeed NoArea


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
