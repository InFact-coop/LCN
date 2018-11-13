module Components.StatsThisWeek exposing (numericalInput, statsThisWeek)

import Components.LawAreaCheckbox exposing (agencyCheckbox, problemCheckbox)
import Components.StyleHelpers exposing (bodyFont, classes, displayElement, headlineFont, promptFont)
import Helpers exposing (ifThenElse, labelToTuple, onBlurValue, onInputValue, removeSpaces, unionTypeToString)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Types exposing (..)


statsThisWeek : Model -> Html Msg
statsThisWeek model =
    let
        peopleSeenText =
            ifThenElse (List.member CaseWorker model.roles)
                "How many client matters have you seen this week in total?"
                "How many enquiries have you had this week in all? (include phone, email, in person)"
    in
    section [ class "mb4 mt4" ]
        [ div [ class "flex flex-row mb4 items-baseline" ]
            [ h1 [ classes [ headlineFont ] ] [ text "Your Week" ]
            , h2 [ classes [ "ml2 db", promptFont ] ] [ text "If you can't remember the ", span [ class "fw5" ] [ text "exact number" ], text ", your ", span [ class "fw5" ] [ text "best estimate" ], text " would do here." ]
            ]
        , div [ class "grid mb4" ]
            [ numericalInput model.peopleSeenWeekly model.postStatsStatus (List.member Triage model.roles || List.member CaseWorker model.roles) peopleSeenText "green" UpdatePeopleSeen
            , numericalInput model.newCasesWeekly model.postStatsStatus (List.member CaseWorker model.roles) "Of these, how many cases, including those of returning clients, were new?" "blue" UpdateNewCases
            , numericalInput model.peopleTurnedAwayWeekly model.postStatsStatus (List.member Triage model.roles) "How many enquiries have you had to turn away without signposting anywhere?" "pink" UpdatePeopleTurnedAway
            , numericalInput model.signpostedInternallyWeekly model.postStatsStatus (List.member Triage model.roles) "How many enquiries were signposted to one-off advice at the Law Centre (e.g. advice line, drop-in or pro bono clinics, where available?)" "orange" UpdateSignpostedInternally
            , numericalInput model.signpostedExternallyWeekly model.postStatsStatus (List.member Triage model.roles) "How many enquiries were referred to other agencies?" "green" UpdateSignpostedExternally
            , numericalInput model.internalAppointmentsWeekly model.postStatsStatus (List.member Triage model.roles) "How many enquiries were taken on by your Law Centre/given an appointment?" "green" UpdateInternalAppointments
            , numericalInput model.studentVolunteersWeekly model.postStatsStatus (List.member Management model.roles) "How many student law volunteers have you had this week?" "pink" UpdateStudentVolunteersWeekly
            , numericalInput model.lawyerVolunteersWeekly model.postStatsStatus (List.member Management model.roles) "How many lawyer volunteers have you had this week?" "orange" UpdateLawyerVolunteersWeekly
            , numericalInput model.vacanciesWeekly model.postStatsStatus (List.member Management model.roles) "How many staff vacancies do you have at the moment?" "green" UpdateVacanciesWeekly
            , numericalInput model.mediaCoverageWeekly model.postStatsStatus (List.member Management model.roles) ("How many media stories has " ++ unionTypeToString model.lawCentre ++ " Law Centre had this week, if any?") "blue" UpdateMediaCoverageWeekly
            ]
        , div [ classes [ "mb4", displayElement (List.member Triage model.roles) ] ]
            [ label [ for "agencyTypes", classes [ "mb4", headlineFont ] ] [ text "Tick the main types of agencies you referred to this week:" ]
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


numericalInput : Maybe Int -> RemoteData -> Bool -> String -> String -> (String -> Msg) -> Html Msg
numericalInput valueFromModel formStatus shouldDisplay labelContent thumbColour msg =
    let
        unpackedValue =
            Maybe.withDefault 0 valueFromModel

        valueString =
            toString unpackedValue

        incrementedValue =
            toString <| unpackedValue + 1

        decrementedValue =
            toString <| unpackedValue - 1

        editableAnswer =
            input [ id <| removeSpaces labelContent, type_ "number", value valueString, classes [ "w3 f2 ba b--light-gray pv1 tc mr3", "number-" ++ thumbColour ], Attr.min "0", onInputValue msg ] []

        uneditableAnswer =
            div [ class "fw5 f2d5 mr3" ] [ text valueString ]
    in
    label
        [ for <| removeSpaces labelContent, classes [ ifThenElse (formStatus == NotAsked || formStatus == ResponseFailure) "pointer" "", "justify-between items-center tl bw1 bb b--light-silver bw1 bb bt pv3", "number-" ++ thumbColour, ifThenElse shouldDisplay "flex" "dn" ] ]
        [ div [ class "w-70 flex flex-column justify-between" ]
            [ div [ classes [ bodyFont ] ]
                [ text <| Tuple.first <| labelToTuple labelContent ]
            , div
                [ classes [ promptFont, "mt2" ] ]
                [ text <| Tuple.second <| labelToTuple labelContent ]
            ]
        , ifThenElse (formStatus == NotAsked || formStatus == ResponseFailure) editableAnswer uneditableAnswer
        ]
