module Views.AddStats exposing (..)

import Components.Button exposing (..)
import Components.LawArea exposing (lawAreaList, lawAreaOption)
import Components.LawAreaCheckbox exposing (problemCheckbox, agencyCheckbox)
import Components.StatsThisWeek exposing (statsThisWeek)
import Components.StyleHelpers exposing (bodyFont, checkboxFont, classes, displayElement, headlineFont)
import Data.LawArea exposing (decoderLawArea, stringToLawArea)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder, andThen)
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
            , section [ class "mb4" ]
                [ h1 [ classes [ "tl mb4", headlineFont ] ]
                    [ text "Weekly survey" ]
                , div
                    []
                    [ h2 [ classes [ "mb3", bodyFont ] ]
                        [ text "What is your role type at the Law Centre?" ]
                    , div [ class "mb4" ] (roleButtonsList model)
                    ]
                , div [ classes [ "mb4", displayElement <| model.role == CaseWorker ] ]
                    [ label [ for "lawArea", classes [ bodyFont ] ] [ text "What is your main area of practice?" ]
                    , div [ class "select mt2 w-25-ns w-100" ]
                        [ select [ id "areaOfLaw", classes [ "br4", checkboxFont ], placeholder "Immigration", on "change" <| Json.Decode.map UpdateLawArea targetValueDecoderLawArea ]
                            (List.map
                                lawAreaOption
                                lawAreaList
                            )
                        ]
                    ]
                , div [ classes [ displayElement <| model.role == CaseWorker && model.lawArea /= NoArea ] ]
                    [ label [ for "lawArea", classes [ bodyFont ] ] [ text "What were the main kinds of problems you have seen this week?" ]
                    , div [ classes [ "mv4" ] ] (problemCheckboxesList model)
                    ]
                , statsThisWeek model
                ]
            , bigColouredButton model "green" "Submit" PostStats
            ]
        ]


introText : String
introText =
    """
    Please tells us a little about the cases you have seen this week. We are collecting this
    rough-and-ready information so LCN and each Law Centre have a better idea of current workloads and
    trends. This will help you see if your experience is similar to that in other Law Centres. It will
    also help LCN to speak out quickly and with better authority about the issues arising.
    """


problemCheckboxesList : Model -> List (Html Msg)
problemCheckboxesList model =
    case model.lawArea of
        WelfareAndBenefits ->
            [ problemCheckbox "Entitlement"
            , problemCheckbox "Overpayment"
            , problemCheckbox "Right to Reside"
            , problemCheckbox "Sanctions"
            , problemCheckbox "Universal Credit"
            , problemCheckbox "PIP"
            , problemCheckbox "ESA"
            , problemCheckbox "DLA"
            , problemCheckbox "JSA"
            , problemCheckbox "Council Tax Reduction"
            , problemCheckbox "Tax Credit"
            , problemCheckbox "Pension Credit"
            , problemCheckbox "Other"
            ]

        Employment ->
            [ problemCheckbox "Working Time"
            , problemCheckbox "Withheld Wages / Notice / Holiday Pay"
            , problemCheckbox "Redundancy Payments"
            , problemCheckbox "Discrimination"
            , problemCheckbox "Breach of Contract"
            , problemCheckbox "Unfair Dismissal"
            , problemCheckbox "Disciplinary / Grievance"
            , problemCheckbox "Whistleblowing"
            , problemCheckbox "Other"
            ]

        Debt ->
            [ problemCheckbox "Council Tax Arrears / Bailiffs"
            , problemCheckbox "Utilities"
            , problemCheckbox "Rent Arrears"
            , problemCheckbox "Mortgage (Arrears or Interest Only)"
            , problemCheckbox "Court Fines"
            , problemCheckbox "Secured or Student Loans"
            , problemCheckbox "Credit Card Debt"
            , problemCheckbox "Overpaid Benefits Clawback"
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
            [ problemCheckbox "Asylum"
            , problemCheckbox "Non-Asylum Immigration"
            , problemCheckbox "Article 8"
            , problemCheckbox "Article 3 / Humanitarian Protection"
            , problemCheckbox "Domestic Violence"
            , problemCheckbox "Family Reunion"
            , problemCheckbox "NRPF"
            , problemCheckbox "Trafficking"
            , problemCheckbox "Children / UASC"
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
            , problemCheckbox "Care at Home"
            , problemCheckbox "Care Home Placement / Supported Living"
            , problemCheckbox "Carers Assessment / Services"
            , problemCheckbox "Children's Act Assessment / Services"
            , problemCheckbox "Payments (Charging, Personal Budget, Direct Payments)"
            , problemCheckbox "Service Reorganisation / Closure"
            , problemCheckbox "Other"
            ]

        PublicLaw ->
            [ problemCheckbox "Social Welfare"
            , problemCheckbox "Human Rights"
            , problemCheckbox "Migrant Support"
            , problemCheckbox "Other"
            ]

        NoArea ->
            []


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
