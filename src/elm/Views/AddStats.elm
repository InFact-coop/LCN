module Views.AddStats exposing (addStatsView, introText, problemCheckboxesList)

import Components.Button exposing (..)
import Components.LawAreaCheckbox exposing (agencyCheckbox, problemCheckbox)
import Components.StatsThisWeek exposing (statsThisWeek)
import Components.StyleHelpers exposing (promptFont, bodyFont, checkboxFont, classes, displayElement, headlineFont)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


addStatsView : Model -> Html Msg
addStatsView model =
    section
        [ classes [ "flex justify-center pa3-ns pv3", ifThenElse model.displayStatsModal "disableButton" "" ] ]
        [ section [ class "w-80-ns w-90" ]
            [ section [ class "mb4" ]
                [ h1 [ classes [ "tl mb3", headlineFont ] ] [ text "Introduction" ]
                , p [ class bodyFont ]
                    [ text introText ]
                ]
            , statsThisWeek model
            , section [ class "mb4" ]
                [ div [ classes [ displayElement <| List.member CaseWorker model.roles && model.lawArea /= NoArea ] ]
                    [ label [ for "lawArea", classes [ headlineFont, "mb1" ] ] [ text "What were the main kinds of problems you have seen this week?" ]
                    , h2 [ classes [ promptFont, "mb3" ] ] [ text "(Please select one option from the dropdown)" ]
                    , div [ classes [ "mb4" ] ] (problemCheckboxesList model)
                    ]
                , bigColouredButton (validate model) "green" "Submit" PostStats
                ]
            ]
        ]


validate : Model -> Bool
validate model =
    let
        caseWorkerValidation =
            (model.lawArea /= NoArea)
                && (model.peopleSeenWeekly /= Nothing)
                && (model.newCasesWeekly /= Nothing)
                && (not <| List.isEmpty model.problems)

        triageValidation =
            (model.peopleSeenWeekly /= Nothing)
                && (model.peopleTurnedAwayWeekly /= Nothing)
                && (model.signpostedInternallyWeekly /= Nothing)
                && (model.signpostedExternallyWeekly /= Nothing)
                && (not <| List.isEmpty model.agencies)

        managementValidation =
            model.volunteersTotalWeekly
                /= Nothing
                && model.studentVolunteersWeekly
                /= Nothing
                && model.lawyerVolunteersWeekly
                /= Nothing
                && model.vacanciesWeekly
                /= Nothing
                && model.mediaCoverageWeekly
                /= Nothing

        roleWithValidation =
            [ ( CaseWorker, caseWorkerValidation )
            , ( Triage, triageValidation )
            , ( Management, managementValidation )
            ]
    in
    roleWithValidation
        |> List.map
            (\( role, validation ) ->
                if List.member role model.roles then
                    validation

                else
                    True
            )
        |> List.all (\validation -> validation == True)


introText : String
introText =
    """
    Please tell us a little about your week. We are collecting this
    rough-and-ready information so LCN and each Law Centre have a better idea of current workloads and
    trends. This will help you see if your experience is similar to that in other Law Centres. It will
    also help LCN to speak out quickly and with better authority about the issues arising.
    """


problemCheckboxesList : Model -> List (Html Msg)
problemCheckboxesList model =
    case model.lawArea of
        WelfareAndBenefits ->
            [ problemCheckbox "Council Tax Reduction"
            , problemCheckbox "DLA"
            , problemCheckbox "ESA"
            , problemCheckbox "Entitlement"
            , problemCheckbox "JSA"
            , problemCheckbox "Overpayment"
            , problemCheckbox "PIP"
            , problemCheckbox "Pension Credit"
            , problemCheckbox "Right to Reside"
            , problemCheckbox "Sanctions"
            , problemCheckbox "Tax Credit"
            , problemCheckbox "Universal Credit"
            , problemCheckbox "Other"
            ]

        Employment ->
            [ problemCheckbox "Breach of Contract"
            , problemCheckbox "Disciplinary / Grievance"
            , problemCheckbox "Discrimination"
            , problemCheckbox "Redundancy Payments"
            , problemCheckbox "Unfair Dismissal"
            , problemCheckbox "Whistleblowing"
            , problemCheckbox "Withheld Wages / Notice / Holiday Pay"
            , problemCheckbox "Working Time"
            , problemCheckbox "Other"
            ]

        Debt ->
            [ problemCheckbox "Council Tax Arrears / Bailiffs"
            , problemCheckbox "Court Fines"
            , problemCheckbox "Credit Card Debt"
            , problemCheckbox "Mortgage (Arrears or Interest Only)"
            , problemCheckbox "Overpaid Benefits Clawback"
            , problemCheckbox "Rent Arrears"
            , problemCheckbox "Secured or Student Loans"
            , problemCheckbox "Utilities"
            , problemCheckbox "Other"
            ]

        Housing ->
            [ problemCheckbox "Allocations"
            , problemCheckbox "Committals"
            , problemCheckbox "Disrepair"
            , problemCheckbox "Duty Scheme"
            , problemCheckbox "Eviction"
            , problemCheckbox "Homelessness"
            , problemCheckbox "Homelessness Review"
            , problemCheckbox "Injunction"
            , problemCheckbox "Possession"
            , problemCheckbox "Other"
            ]

        ImmigrationAndAsylum ->
            [ problemCheckbox "Article 3 / Humanitarian Protection"
            , problemCheckbox "Article 8"
            , problemCheckbox "Asylum"
            , problemCheckbox "Children / UASC"
            , problemCheckbox "Domestic Violence"
            , problemCheckbox "Family Reunion"
            , problemCheckbox "NRPF"
            , problemCheckbox "Trafficking"
            , problemCheckbox "Other"
            ]

        Family ->
            [ problemCheckbox "Care Proceedings"
            , problemCheckbox "Child Abduction"
            , problemCheckbox "Child Arrangement Orders"
            , problemCheckbox "Divorce"
            , problemCheckbox "Domestic Violence"
            , problemCheckbox "Financial Matters"
            , problemCheckbox "Other"
            ]

        CommunityCare ->
            [ problemCheckbox "Aids and Adaptations"
            , problemCheckbox "Assessments for Care / Support"
            , problemCheckbox "Best Interest Decision Making"
            , problemCheckbox "Care / Support Planning"
            , problemCheckbox "Care Home Placement / Supported Living"
            , problemCheckbox "Care at Home"
            , problemCheckbox "Carers Assessment / Services"
            , problemCheckbox "Children's Act Assessment / Services"
            , problemCheckbox "Payments (Charging, Personal Budget, Direct Payments)"
            , problemCheckbox "Service Reorganisation / Closure"
            , problemCheckbox "Other"
            ]

        PublicLaw ->
            [ problemCheckbox "Human Rights"
            , problemCheckbox "Migrant Support"
            , problemCheckbox "Social Welfare"
            , problemCheckbox "Other"
            ]

        NoArea ->
            []
