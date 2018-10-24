module Components.StatsThisWeek exposing (numericalInput, statsThisWeek)

import Components.LawAreaCheckbox exposing (agencyCheckbox, problemCheckbox)
import Components.StyleHelpers exposing (bodyFont, classes, displayElement, headlineFont)
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
            , h2 [ classes [ "ml2 fw3" ] ] [ text "(If you don't remember exactly, give us your best estimate)" ]
            ]
        , div []
            [ numericalInput model.peopleSeenWeekly (List.member Management model.roles |> not) peopleSeenText "green" UpdatePeopleSeen
            , numericalInput model.newCasesWeekly (List.member CaseWorker model.roles) "Of these, how many cases were new? (Include returning clients)" "pink" UpdateNewCases
            , numericalInput model.peopleTurnedAwayWeekly (List.member Triage model.roles) "How many enquiries have you had to turn away without signposting anywhere?" "blue" UpdatePeopleTurnedAway
            , numericalInput model.signpostedInternallyWeekly (List.member Triage model.roles) "How many enquiries were signposted to one-off Law Centre advice? (include drop-in & pro-bono clinics)" "orange" UpdateSignpostedInternally
            , numericalInput model.signpostedExternallyWeekly (List.member Triage model.roles) "How many enquiries were referred to other agencies?" "pink" UpdateSignpostedExternally
            , numericalInput model.volunteersTotalWeekly (List.member Management model.roles) "How many volunteers have you had this week in total? (Please count both new and existing volunteers)" "pink" UpdateVolunteersTotalWeekly
            , numericalInput model.studentVolunteersWeekly (List.member Management model.roles) "How many of these were student volunteers?" "blue" UpdateStudentVolunteersWeekly
            , numericalInput model.lawyerVolunteersWeekly (List.member Management model.roles) "How many of these were lawyer volunteers" "green" UpdateLawyerVolunteersWeekly
            , numericalInput model.vacanciesWeekly (List.member Management model.roles) "How many vacancies do you have at the moment?" "orange" UpdateVacanciesWeekly
            , numericalInput model.mediaCoverageWeekly (List.member Management model.roles) ("Has " ++ unionTypeToString model.lawCentre ++ " Law Centre had any media coverage this week?") "pink" UpdateMediaCoverageWeekly
            , div [ classes [ "mb4", displayElement (List.member Triage model.roles) ] ]
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
            [ text <| Tuple.first <| labelToTuple labelContent ]
        , label [ class "f5 fw3 db" ] [ text <| Tuple.second <| labelToTuple labelContent ]
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
