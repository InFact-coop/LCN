module Components.StatsThisWeek exposing (numericalInput, statsThisWeek)

import Components.LawAreaCheckbox exposing (agencyCheckbox)
import Components.StyleHelpers exposing (bodyFont, classes, displayElement, headlineFont, promptFont)
import Data.Problems exposing (problemCheckboxesList)
import Helpers exposing (ifThenElse, labelToTuple, onBlurValue, onInputValue, removeSpaces, unionTypeToString)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Types exposing (..)


division : String -> String -> Html Msg
division copy colour =
    div [ class <| "db pb3 mb3 f4 lh-copy fw5 b--" ++ colour ++ " bw1 bb" ]
        [ text copy ]


statsThisWeek : Model -> Html Msg
statsThisWeek model =
    section [ class "mb4 mt4" ]
        [ div [ class "flex flex-row mb4 items-baseline" ]
            [ h1 [ classes [ headlineFont ] ] [ text <| ifThenElse (model.postStatsStatus == ResponseSuccess || model.postStatsStatus == UserConfirmation || model.postStatsStatus == Loading) "Your Answers for this Week:" "Your Week" ]
            , h2 [ classes [ "ml2", promptFont, displayElement <| model.postStatsStatus /= ResponseSuccess && model.postStatsStatus /= UserConfirmation && model.postStatsStatus /= Loading ] ] [ text "If you can't remember the ", span [ class "fw5" ] [ text "exact number" ], text ", your ", span [ class "fw5" ] [ text "best estimate" ], text " would do here." ]
            ]
        , div [ class <| ifThenElse (List.member Management model.roles) "" "dn" ]
            [ division "Management" "green"
            , div [ class "grid mb4" ]
                [ numericalInput model.studentVolunteersWeekly model.postStatsStatus (List.member Management model.roles) "How many student law volunteers have you had this week?" "green" UpdateStudentVolunteersWeekly
                , numericalInput model.lawyerVolunteersWeekly model.postStatsStatus (List.member Management model.roles) "How many lawyer volunteers have you had this week?" "green" UpdateLawyerVolunteersWeekly
                , numericalInput model.vacanciesWeekly model.postStatsStatus (List.member Management model.roles) "How many staff vacancies do you have at the moment?" "green" UpdateVacanciesWeekly
                , numericalInput model.mediaCoverageWeekly model.postStatsStatus (List.member Management model.roles) ("How many media stories has " ++ unionTypeToString model.lawCentre ++ " Law Centre had this week, if any?") "green" UpdateMediaCoverageWeekly
                ]
            ]
        , div [ class <| ifThenElse (List.member CaseWorker model.roles) "" "dn" ]
            [ division "Lawyer/Case Worker" "pink"
            , div [ class "grid mb4" ]
                [ numericalInput model.clientMattersWeekly model.postStatsStatus (List.member CaseWorker model.roles) "How many client matters have you seen this week in total?" "pink" UpdateClientMatters
                , numericalInput model.newCasesWeekly model.postStatsStatus (List.member CaseWorker model.roles) "Of these, how many cases, including those of returning clients, were new?" "pink" UpdateNewCases
                ]
            , div [ classes [ displayElement <| List.member CaseWorker model.roles && model.lawArea /= NoArea ] ]
                [ div [ class "mb3" ]
                    [ label [ for "lawArea", classes [ headlineFont, "mb1" ] ] [ text <| ifThenElse (model.postStatsStatus == ResponseSuccess || model.postStatsStatus == UserConfirmation || model.postStatsStatus == Loading) "The main kinds of problems you've seen this week:" "Tick the main kinds of problems you've seen this week:" ]
                    , h2 [ classes [ promptFont, "mt1", displayElement (model.postStatsStatus == NotAsked || model.postStatsStatus == ResponseFailure) ] ] [ text "(Please tick all that apply)" ]
                    ]
                , div [ classes [ "mb4" ] ] (problemCheckboxesList model)
                ]
            ]
        , div [ class <| ifThenElse (List.member Triage model.roles) "" "dn" ]
            [ division "Triage/Reception" "orange"
            , div [ class "grid mb4" ]
                [ numericalInput model.enquiriesWeekly model.postStatsStatus (List.member Triage model.roles) "How many enquiries have you had this week in all? (include phone, email, in person)" "orange" UpdateEnquiries
                , numericalInput model.peopleTurnedAwayWeekly model.postStatsStatus (List.member Triage model.roles) "How many enquiries have you had to turn away without signposting anywhere?" "orange" UpdatePeopleTurnedAway
                , numericalInput model.signpostedInternallyWeekly model.postStatsStatus (List.member Triage model.roles) "How many enquiries were signposted to one-off advice at the Law Centre (e.g. advice line, drop-in or pro bono clinics, where available?)" "orange" UpdateSignpostedInternally
                , numericalInput model.signpostedExternallyWeekly model.postStatsStatus (List.member Triage model.roles) "How many enquiries were referred to other agencies?" "orange" UpdateSignpostedExternally
                , numericalInput model.internalAppointmentsWeekly model.postStatsStatus (List.member Triage model.roles) "How many enquiries were taken on by your Law Centre/given an appointment?" "orange" UpdateInternalAppointments
                ]
            , div [ classes [ displayElement (List.member Triage model.roles) ] ]
                [ div [ class "mb3" ] [
                    label [ for "agencyTypes", classes [ headlineFont ] ] [ text <| ifThenElse (model.postStatsStatus == ResponseSuccess || model.postStatsStatus == UserConfirmation || model.postStatsStatus == Loading) "The main types of agencies you referred to this week:" "Tick the main types of agencies you referred to this week:" ]
                    , h2 [ classes [ promptFont, "mt1", displayElement (model.postStatsStatus == NotAsked || model.postStatsStatus == ResponseFailure) ] ] [ text "(Please tick all that apply)" ]
                ]
                , div [ class "mt2" ]
                    [ agencyCheckbox "Local advice agency" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.agencies
                    , agencyCheckbox "Local non-advice support agency" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.agencies
                    , agencyCheckbox "National agency/helpline" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.agencies
                    , agencyCheckbox "Local MPs" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.agencies
                    , agencyCheckbox "Local councillors" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.agencies
                    , agencyCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.agencies
                    ]
                ]
            ]
        ]


numericalInput : Int -> RemoteData -> Bool -> String -> String -> (String -> Msg) -> Html Msg
numericalInput valueFromModel formStatus shouldDisplay labelContent thumbColour msg =
    let
        valueString =
            toString valueFromModel

        incrementedValue =
            toString <| valueFromModel + 1

        decrementedValue =
            toString <| valueFromModel - 1

        editableAnswer =
            input [ id <| removeSpaces labelContent, type_ "number", value valueString, classes [ "w3 f2 ba b--light-gray pv1 tc mr3", "number-" ++ thumbColour ], Attr.min "0", onInputValue msg ] []

        uneditableAnswer =
            div [ class "fw5 f2d5 mr3" ] [ text valueString ]
    in
    label
        [ for <| removeSpaces labelContent, classes [ ifThenElse (formStatus == NotAsked || formStatus == ResponseFailure) "pointer" "", "justify-between items-center tl bw1 bb b--light-silver bw1 pv3", "number-" ++ thumbColour, ifThenElse shouldDisplay "flex" "dn" ] ]
        [ div [ class "w-70 flex flex-column justify-between" ]
            [ div [ classes [ bodyFont ] ]
                [ text <| Tuple.first <| labelToTuple labelContent ]
            , div
                [ classes [ promptFont, "mt2" ] ]
                [ text <| Tuple.second <| labelToTuple labelContent ]
            ]
        , ifThenElse (formStatus == NotAsked || formStatus == ResponseFailure) editableAnswer uneditableAnswer
        ]
