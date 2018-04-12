module Components.StatsThisWeek exposing (..)

import Components.LawAreaCheckbox exposing (agencyCheckbox, problemCheckbox)
import Components.StyleHelpers exposing (bodyFont, classes, displayElement, headlineFont)
import Helpers exposing (ifThenElse, onInputValue, onBlurValue, removeSpaces)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Types exposing (..)


statsThisWeek : Model -> Html Msg
statsThisWeek model =
    let
        peopleSeenText =
            ifThenElse (model.role == CaseWorker)
                "How many cases have you seen this week in total?"
                "How many enquiries have you had this week in all? (include phone, email, in person)"
    in
        section [ class "mb4 mt4" ]
            [ div [ class "flex flex-row mb4 items-baseline" ]
                [ h1 [ classes [ headlineFont ] ] [ text "Your Week" ]
                , h2 [ classes [ "ml2 fw3" ] ] [ text "(If you don't remember exactly, give us your best estimate)" ]
                ]
            , div []
                [ numericalInput model.peopleSeenWeekly True peopleSeenText "green" UpdatePeopleSeen
                , numericalInput model.newCasesWeekly (model.role == CaseWorker) "Of these, how many cases were new (even with a returning client)?" "pink" UpdateNewCases
                , numericalInput model.peopleTurnedAwayWeekly (model.role == Triage) "How many enquiries have you had to turn away without signposting anywhere?" "blue" UpdatePeopleTurnedAway
                , numericalInput model.signpostedInternallyWeekly (model.role == Triage) "How many enquiries were signposted to one-off Law Centre advice? (include drop in or pro bono clinics)" "orange" UpdateSignpostedInternally
                , numericalInput model.signpostedExternallyWeekly (model.role == Triage) "How many enquiries were referred to other agencies?" "pink" UpdateSignpostedExternally
                , div [ classes [ "mb4", displayElement (model.role == Triage) ] ]
                    [ label [ for "agencyTypes", classes [ "mb4", bodyFont ] ] [ text "Tick the main types of agencies you referred to this week:" ]
                    , div [ class "mt2" ]
                        [ agencyCheckbox "Local advice agency"
                        , agencyCheckbox "Local non-advice support agency"
                        , agencyCheckbox "National agency/helpline"
                        , agencyCheckbox "Local MPs"
                        , agencyCheckbox "Local councillors"
                        , agencyCheckbox "Other"
                        ]
                    ]
                ]
            ]


numericalInput : Maybe Int -> Bool -> String -> String -> (String -> Msg) -> Html Msg
numericalInput valueFromModel shouldDisplay labelContent thumbColour msg =
    let
        maybeValue =
            case valueFromModel of
                Just number ->
                    toString number

                Nothing ->
                    ""
    in
        div
            [ classes [ "mb5", displayElement shouldDisplay ] ]
            [ label [ for <| removeSpaces labelContent, classes [ "mb4", bodyFont ] ]
                [ text labelContent ]
            , input
                [ id <| removeSpaces labelContent
                , type_ "range"
                , Attr.min "0"
                , Attr.max "50"
                , step "1"
                , value maybeValue
                , classes [ "w-75 bg-white br-pill input-reset h-custom slider mt3", thumbColour ++ "-thumb" ]
                , onInputValue msg
                ]
                []
            , input [ type_ "number", value maybeValue, class "mt3 ml3 dib f5 ba br3 b--light-gray pv1 tc w2d5", onBlurValue msg ] []
            ]
