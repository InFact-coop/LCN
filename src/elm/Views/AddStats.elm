module Views.AddStats exposing (addStatsView, introText, problemCheckboxesList)

import Components.Button exposing (..)
import Components.LawAreaCheckbox exposing (agencyCheckbox, problemCheckbox)
import Components.StatsThisWeek exposing (statsThisWeek)
import Components.StyleHelpers exposing (bodyFont, checkboxFont, classes, displayElement, emptySpan, headlineFont, promptFont)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


submitButton : Model -> Html Msg
submitButton model =
    case model.postStatsStatus of
        UserConfirmation ->
            bigColouredButton True "green" "Confirm" PostStats

        Loading ->
            bigColouredButton True
                "gray"
                "..."
                NoOp

        ResponseFailure ->
            bigColouredButton True
                "red"
                "Try again"
                PostStats

        NotAsked ->
            bigColouredButton True "green" "Submit" ConfirmStats

        ResponseSuccess ->
            emptySpan


editButton : Model -> Html Msg
editButton model =
    bigColouredButton True "orange" "Go back" EditStats


callsToAction : Model -> Html Msg
callsToAction model =
    div []
        [ ifThenElse (model.postStatsStatus == UserConfirmation) (editButton model) emptySpan
        , submitButton model
        ]


addStatsView : Model -> Html Msg
addStatsView model =
    section
        [ classes [ "flex justify-center pa3-ns pv3", ifThenElse model.displayStatsModal "disableButton" "" ] ]
        [ section [ class "w-80-ns w-90" ]
            [ section [ class "mb4" ]
                [ h1 [ classes [ "tl mb3", headlineFont ] ] [ text "Introduction" ]
                , p [ class bodyFont ]
                    introText
                ]
            , statsThisWeek model
            , section [ class "mb4" ]
                [ div [ classes [ displayElement <| List.member CaseWorker model.roles && model.lawArea /= NoArea ] ]
                    [ label [ for "lawArea", classes [ headlineFont, "mb1" ] ] [ text <| ifThenElse (model.postStatsStatus == ResponseSuccess || model.postStatsStatus == UserConfirmation) "The main types of agencies you referred to this week:" "Tick the main types of agencies you referred to this week:" ]
                    , h2 [ classes [ promptFont, "mb3 mt1", displayElement (model.postStatsStatus /= ResponseSuccess && model.postStatsStatus /= UserConfirmation) ] ] [ text "(Please select one option from the dropdown)" ]
                    , div [ classes [ "mb4" ] ] (problemCheckboxesList model)
                    ]
                , callsToAction
                    model
                ]
            ]
        ]


introText : List (Html Msg)
introText =
    [ text "Please ", span [ class "fw5" ] [ text "tell us a little about your week " ], text "since the last time you checked in. You can ", span [ class "fw5" ] [ text "type" ], text ", ", span [ class "fw5" ] [ text "use the spinner buttons" ], text ", or ", span [ class "fw5" ] [ text " use the arrows on your keyboard " ], text "to provide your answer." ]


problemCheckboxesList : Model -> List (Html Msg)
problemCheckboxesList model =
    case model.lawArea of
        WelfareAndBenefits ->
            [ problemCheckbox "Carers' Allowance" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Council Tax Reduction" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "DLA" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "ESA" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Entitlement" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "JSA" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Overpayment" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "PIP" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Pension Credit" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Right to Reside" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Sanctions" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Tax Credit" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Universal Credit" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation)
            ]

        Employment ->
            [ problemCheckbox "Breach of Contract" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Constructive Dismissal" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Disciplinary / Grievance" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Discrimination" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Redundancy Payments" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Unfair Dismissal" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Whistleblowing" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Withheld Wages / Notice / Holiday Pay" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Working Time" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation)
            ]

        Debt ->
            [ problemCheckbox "Council Tax Arrears / Bailiffs" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Court Fines" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Credit Card Debt" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Mortgage (Arrears or Interest Only)" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Overpaid Benefits Clawback" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Rent Arrears" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Secured or Student Loans" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Utilities" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation)
            ]

        Housing ->
            [ problemCheckbox "Allocations" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Committals" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Disrepair" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Duty Scheme" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Eviction" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Homelessness" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Homelessness Review" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Injunction" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Possession" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation)
            ]

        ImmigrationAndAsylum ->
            [ problemCheckbox "Article 3 / Humanitarian Protection" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Article 8" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Asylum" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Children / UASC" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Domestic Violence" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Family Reunion" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "NRPF" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Trafficking" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation)
            ]

        Family ->
            [ problemCheckbox "Care Proceedings" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Child Abduction" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Child Arrangement Orders" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Divorce" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Domestic Violence" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Financial Matters" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation)
            ]

        CommunityCare ->
            [ problemCheckbox "Aids and Adaptations" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Assessments for Care / Support" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Best Interest Decision Making" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Care / Support Planning" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Care Home Placement / Supported Living" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Care at Home" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Carers Assessment / Services" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Children's Act Assessment / Services" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Payments (Charging, Personal Budget, Direct Payments)" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Service Reorganisation / Closure" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation)
            ]

        PublicLaw ->
            [ problemCheckbox "Human Rights" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Migrant Support" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Social Welfare" (model.postStatsStatus == UserConfirmation)
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation)
            ]

        NoArea ->
            []
