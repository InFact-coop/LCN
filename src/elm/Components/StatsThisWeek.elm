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
            , h2 [ classes [ "ml2", promptFont ] ] [ text "(If you don't remember exactly, give us your best estimate)" ]
            ]
        , div [ class "grid mb4" ]
            [ numericalInput model.peopleSeenWeekly (List.member Triage model.roles || List.member CaseWorker model.roles) peopleSeenText "green" UpdatePeopleSeen
            , numericalInput model.newCasesWeekly (List.member CaseWorker model.roles) "Of these, how many cases were new? (Include returning clients)" "blue" UpdateNewCases
            , numericalInput model.peopleTurnedAwayWeekly (List.member Triage model.roles) "How many enquiries have you had to turn away without signposting anywhere?" "pink" UpdatePeopleTurnedAway
            , numericalInput model.signpostedInternallyWeekly (List.member Triage model.roles) "How many enquiries were signposted to one-off Law Centre advice? (include drop-in & pro-bono clinics)" "orange" UpdateSignpostedInternally
            , numericalInput model.signpostedExternallyWeekly (List.member Triage model.roles) "How many enquiries were referred to other agencies?" "pink" UpdateSignpostedExternally
            , numericalInput model.volunteersTotalWeekly (List.member Management model.roles) "How many volunteers have you had this week in total? (Please count both new and existing volunteers)" "pink" UpdateVolunteersTotalWeekly
            , numericalInput model.studentVolunteersWeekly (List.member Management model.roles) "How many of these were student volunteers?" "blue" UpdateStudentVolunteersWeekly
            , numericalInput model.lawyerVolunteersWeekly (List.member Management model.roles) "How many of these were lawyer volunteers" "green" UpdateLawyerVolunteersWeekly
            , numericalInput model.vacanciesWeekly (List.member Management model.roles) "How many vacancies do you have at the moment?" "orange" UpdateVacanciesWeekly
            , numericalInput model.mediaCoverageWeekly (List.member Management model.roles) ("Has " ++ unionTypeToString model.lawCentre ++ " Law Centre had any media coverage this week?") "pink" UpdateMediaCoverageWeekly
            , div [ classes [ "mb4", displayElement (List.member Triage model.roles) ] ]
                [ label [ for "agencyTypes", classes [ "mb1", headlineFont ] ] [ text "Tick the main types of agencies you referred to this week:" ]
                , h2 [ classes [ promptFont, "mb3" ] ] [ text "(Please select all that apply)" ]
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
        unpackedValue =
            Maybe.withDefault 0 valueFromModel

        valueString =
            toString unpackedValue

        incrementedValue =
            toString <| unpackedValue + 1

        decrementedValue =
            toString <| unpackedValue - 1
    in
    label
        [ for <| removeSpaces labelContent, classes [ "pointer flex justify-between items-center tl bw1 bb b--light-silver bw1 bb bt pv3", "number-" ++ thumbColour, displayElement shouldDisplay ] ]
        [ div [ class "w-70 flex flex-column justify-between" ]
            [ div [ classes [ bodyFont ] ]
                [ text <| Tuple.first <| labelToTuple labelContent ]
            , div
                [ classes [ promptFont, "mt2" ] ]
                [ text <| Tuple.second <| labelToTuple labelContent ]
            ]
        , input [ id <| removeSpaces labelContent, type_ "number", value valueString, classes [ "w3 f2 ba b--light-gray pv1 tc mr3", "number-" ++ thumbColour ], Attr.min "0", onBlurValue msg ] []
        ]
