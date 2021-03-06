module Views.BeforeYouBegin exposing
    ( beforeYouBegin
    , introText
    , roleButtonsList
    , targetValueDecoderLC
    , targetValueDecoderLawArea
    )

import Components.Button exposing (..)
import Components.LawArea exposing (lawAreaList, lawAreaOption)
import Components.LawCentre exposing (lawCentreList, lawCentreOption)
import Components.StyleHelpers exposing (bodyFont, classes, displayElement, headlineFont, promptFont)
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
                    introText
                ]
            , section [ class "mb4" ]
                [ h1 [ classes [ "tl mb1", headlineFont ] ]
                    [ text "Which Law Centre do you work for?" ]
                , h2 [ classes [ promptFont, "mb3 mt1" ] ] [ text "(Please select one option from the dropdown)" ]
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
                , h1 [ classes [ "tl mb1", headlineFont ] ]
                    [ text <| "What is your role at " ++ ifThenElse (model.lawCentre == NoCentre) "your " (unionTypeToString model.lawCentre) ++ "  Law Centre?" ]
                , h2 [ classes [ promptFont, "mb3" ] ] [ text "(Please select all that apply)" ]
                , div [ class "mb4" ] (roleButtonsList model)
                , div [ classes [ "mb4", displayElement <| List.member CaseWorker model.roles ] ]
                    [ h1 [ class "mb1" ] [ label [ for "lawArea", classes [ headlineFont, "tl" ] ] [ text "What is your main area of practice?" ] ]
                    , h2 [ classes [ promptFont, "mb3 mt1" ] ] [ text "(Please select one option from the dropdown)" ]
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
                , submitButton model
                ]
            ]
        ]


submitButton : Model -> Html Msg
submitButton model =
    case model.postStatsStatus of
        Loading ->
            bigColouredButton True
                "gray"
                "..."
                NoOp

        _ ->
            bigColouredButton (validate model) "green" "Submit" PostNewUserDetails


validate : Model -> Bool
validate model =
    let
        defaultValidation =
            model.lawCentre
                /= NoCentre
                && model.roles
                /= [ NoRole ]

        caseWorkerValidation =
            (model.lawArea /= NoArea)
                && (model.lawCentre /= NoCentre)

        roleWithValidation =
            [ ( CaseWorker, caseWorkerValidation )
            , ( NoRole, defaultValidation )
            ]
    in
    roleWithValidation
        |> List.map
            (\( role, validation ) ->
                if role == NoRole then
                    validation

                else if List.member role model.roles then
                    validation

                else
                    True
            )
        |> List.all (\validation -> validation == True)


introText : List (Html Msg)
introText =
    [ text "We’d just like to ", span [ class "fw5" ] [ text "take a few details" ], text " as to what you do at LCN. Don’t worry, we ", span [ class "fw5" ] [ text "won’t ask for this information again" ], text "." ]


roleButtonsList : Model -> List (Html Msg)
roleButtonsList model =
    let
        chooseClass role =
            if List.member role model.roles then
                "grow"

            else
                "o-30 shrink"
    in
    [ colouredButton ("pink " ++ chooseClass CaseWorker) CaseWorker
    , colouredButton ("orange " ++ chooseClass Triage) Triage
    , colouredButton ("green " ++ chooseClass Management) Management
    ]


targetValueDecoderLawArea : Decoder LawArea
targetValueDecoderLawArea =
    targetValue
        |> andThen decoderLawArea


targetValueDecoderLC : Decoder LawCentre
targetValueDecoderLC =
    targetValue
        |> andThen decoderLC
