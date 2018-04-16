module Views.BeforeYouBegin exposing (..)

import Components.Button exposing (..)
import Components.LawArea exposing (lawAreaList, lawAreaOption)
import Components.LawCentre exposing (lawCentreList, lawCentreOption)
import Components.StyleHelpers exposing (bodyFont, classes, displayElement, headlineFont)
import Data.LawArea exposing (decoderLawArea)
import Data.LawCentre exposing (decoderLC)
import Helpers exposing (ifThenElse, unionTypeToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder, andThen)
import Types exposing (..)


beforeYouBegin : Model -> Html Msg
beforeYouBegin model =
    section
        [ classes [ "flex justify-center pa3-ns pv3", ifThenElse model.displayStatsModal "disableButton" "" ] ]
        [ section [ class "w-80-ns w-90" ]
            [ section [ class "mb4" ]
                [ h1 [ classes [ "tl mb3", headlineFont ] ] [ text "Thank you for signing up!" ]
                , p [ class bodyFont ]
                    [ text introText ]
                ]
            , section [ class "mb4" ]
                [ h1 [ classes [ "tl mb3", headlineFont ] ]
                    [ text "Which Law Centre do you work for?" ]
                , div [ class "mb4 bw1 ba b--light-gray new-select w-40-l w-100 relative flex items-center justify-center green-drop" ]
                    [ select
                        [ classes
                            [ "f4 fw3"
                            , "tc pv3 w-100"
                            , "override-select"
                            ]
                        , on "change" <| Json.Decode.map UpdateLawCentre targetValueDecoderLC
                        ]
                        (List.map lawCentreOption lawCentreList)
                    ]
                , h1 [ classes [ "tl mb3", headlineFont ] ]
                    [ text <| "What is your role at " ++ ifThenElse (model.lawCentre == NoCentre) ("your ") (unionTypeToString model.lawCentre) ++ "  Law Centre?" ]
                , div [ class "mb4" ] (roleButtonsList model)
                , div [ classes [ "mb4", displayElement <| model.role == CaseWorker ] ]
                    [ div [ class "mb3" ] [ label [ for "lawArea", classes [ headlineFont, "tl" ] ] [ text "What is your main area of practice?" ] ]
                    , div [ class "bw1 ba b--light-gray new-select pink-drop w-40-l w-100 relative flex items-center justify-center" ]
                        [ select
                            [ classes
                                [ "tc pv3 w-100"
                                , "f4 fw3"
                                , "override-select"
                                ]
                            , on "change" <| Json.Decode.map UpdateLawArea targetValueDecoderLawArea
                            ]
                            (List.map
                                lawAreaOption
                                lawAreaList
                            )
                        ]
                    ]
                , bigColouredButton model "green" (ifThenElse (model.postUserDetailsStatus == Loading) "..." "Submit") PostNewUserDetails
                ]
            ]
        ]


introText : String
introText =
    """
    We’d just like to take a few details as to what you do at LCN. Don’t worry, we won’t ask for this information again.
    """


roleButtonsList : Model -> List (Html Msg)
roleButtonsList model =
    case model.role of
        CaseWorker ->
            [ colouredButton ("pink grow") CaseWorker
            , colouredButton ("orange o-30 shrink") Triage
            , colouredButton ("green o-30 shrink") Management
            ]

        Management ->
            [ colouredButton ("pink o-30 shrink") CaseWorker
            , colouredButton ("orange o-30 shrink") Triage
            , colouredButton ("green grow") Management
            ]

        Triage ->
            [ colouredButton ("pink o-30 shrink") CaseWorker
            , colouredButton ("orange grow") Triage
            , colouredButton ("green o-30 shrink") Management
            ]

        NoRole ->
            [ colouredButton ("pink o-30 shrink") CaseWorker
            , colouredButton ("orange o-30 shrink") Triage
            , colouredButton ("green o-30 shrink") Management
            ]


targetValueDecoderLawArea : Decoder LawArea
targetValueDecoderLawArea =
    targetValue
        |> andThen decoderLawArea


targetValueDecoderLC : Decoder LawCentre
targetValueDecoderLC =
    targetValue
        |> andThen decoderLC