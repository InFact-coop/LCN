module Components.StatsThisWeek exposing (numericalInput, statsThisWeek)

import Components.LawAreaCheckbox exposing (agencyCheckbox, problemCheckbox)
import Components.StyleHelpers exposing (bodyFont, classes, displayElement, headlineFont)
import Helpers exposing (ifThenElse, labelToTuple, onBlurValue, onInputValue, removeSpaces, unionTypeToString)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


statsThisWeek : Model -> Html Msg
statsThisWeek model =
    let
        peopleSeenText =
            ifThenElse (model.role == CaseWorker)
                "How many client matters have you seen this week in total?"
                "How many enquiries have you had this week in all? (include phone, email, in person)"
    in
    section [ class "mb4 mt4" ]
        [ div [ class "flex flex-row mb4 items-baseline" ]
            [ h1 [ classes [ headlineFont ] ] [ text "Your Week" ]
            , h2 [ classes [ "ml2 fw3" ] ] [ text "(If you don't remember exactly, give us your best estimate)" ]
            ]
        , div [ class "grid" ]
            [ numericalInput model.peopleSeenWeekly (model.role /= Management) peopleSeenText "green" UpdatePeopleSeen
            , numericalInput model.newCasesWeekly (model.role == CaseWorker) "Of these, how many cases were new? (Include returning clients)" "pink" UpdateNewCases
            , numericalInput model.peopleTurnedAwayWeekly (model.role == Triage) "How many enquiries have you had to turn away without signposting anywhere?" "blue" UpdatePeopleTurnedAway
            , numericalInput model.signpostedInternallyWeekly (model.role == Triage) "How many enquiries were signposted to one-off Law Centre advice? (include drop-in & pro-bono clinics)" "orange" UpdateSignpostedInternally
            , numericalInput model.signpostedExternallyWeekly (model.role == Triage) "How many enquiries were referred to other agencies?" "pink" UpdateSignpostedExternally
            , numericalInput model.volunteersTotalWeekly (model.role == Management) "How many volunteers have you had this week in total? (Please count both new and existing volunteers)" "pink" UpdateVolunteersTotalWeekly
            , numericalInput model.studentVolunteersWeekly (model.role == Management) "How many of these were student volunteers?" "blue" UpdateStudentVolunteersWeekly
            , numericalInput model.lawyerVolunteersWeekly (model.role == Management) "How many of these were lawyer volunteers?" "green" UpdateLawyerVolunteersWeekly
            , numericalInput model.vacanciesWeekly (model.role == Management) "How many vacancies do you have at the moment?" "orange" UpdateVacanciesWeekly
            , numericalInput model.mediaCoverageWeekly (model.role == Management) ("Has " ++ unionTypeToString model.lawCentre ++ " Law Centre had any media coverage this week?") "pink" UpdateMediaCoverageWeekly
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
            , div [ class "f5 fw3 i mt2" ] [ text <| Tuple.second <| labelToTuple labelContent ]
            ]
        , input [ id <| removeSpaces labelContent, type_ "number", value valueString, classes [ "w3 f2 ba b--light-gray pv1 tc mr3", "number-" ++ thumbColour ], Attr.min "0", onBlurValue msg ] []
        ]



-- [ button [ classes [ "b white bn br1 ph2 f4", ifThenElse (unpackedValue == 0) "bg-silver" "bg-blue pointer" ], onClick <| msg decrementedValue ] [ text "-" ]
-- , button [ class "b white bn br1 ph2 f4 bg-orange pointer", onClick <| msg incrementedValue ] [ text "+" ]
