module Views.AddStats exposing (..)

import Components.Button exposing (..)
import Components.LawArea exposing (lawAreaList, lawAreaOption)
import Components.LawAreaCheckbox exposing (lawAreaCheckbox)
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
                    , div [ classes [ "mv4" ] ] (lawAreaCheckboxesList model)
                    ]
                , section [ class "mb4 mt4" ]
                    [ h1 [ classes [ "tl mb4", headlineFont ] ]
                        [ text "Your Week" ]
                    , div []
                        [ div
                            [ class "db mb4" ]
                            [ label [ for "peopleSeenWeekly", classes [ "mb4", bodyFont ] ]
                                [ text "How many people have you seen this week?" ]
                            , input [ id "peopleSeenWeekly", type_ "number", class "mt3 db br4 bw1 pa2 f3 ba b--light-gray", size 3, onInput UpdatePeopleSeen ] []
                            ]
                        , div
                            [ class "db mb4" ]
                            [ label [ for "peopleTurnedAwayWeekly", classes [ "mb4", bodyFont ] ]
                                [ text "How many people have you turned away this week?" ]
                            , input [ id "peopleTurnedAwayWeekly", type_ "number", class "mt3 db br4 bw1 pa2 f3 ba b--light-gray", size 3, onInput UpdatePeopleTurnedAway ] []
                            ]
                        ]
                    ]
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


lawAreaCheckboxesList : Model -> List (Html Msg)
lawAreaCheckboxesList model =
    case model.lawArea of
        WelfareAndBenefits ->
            [ lawAreaCheckbox "Entitlement"
            , lawAreaCheckbox "Overpayment"
            , lawAreaCheckbox "Right to Reside"
            , lawAreaCheckbox "Sanctions"
            , lawAreaCheckbox "Universal Credit"
            , lawAreaCheckbox "PIP"
            , lawAreaCheckbox "ESA"
            , lawAreaCheckbox "DLA"
            , lawAreaCheckbox "JSA"
            , lawAreaCheckbox "Council Tax Reduction"
            , lawAreaCheckbox "Tax Credit"
            , lawAreaCheckbox "Pension Credit"
            ]

        Employment ->
            [ lawAreaCheckbox "Working Time"
            , lawAreaCheckbox "Withheld Wages / Notice / Holiday Pay"
            , lawAreaCheckbox "Redundancy Payments"
            , lawAreaCheckbox "Discrimination"
            , lawAreaCheckbox "Breach of Contract"
            , lawAreaCheckbox "Unfair Dismissal"
            , lawAreaCheckbox "Disciplinary / Grievance"
            , lawAreaCheckbox "Whistleblowing"
            ]

        Debt ->
            [ lawAreaCheckbox "Council Tax Arrears / Bailiffs"
            , lawAreaCheckbox "Utilities"
            , lawAreaCheckbox "Rent Arrears"
            , lawAreaCheckbox "Mortgage (Arrears or Interest Only)"
            , lawAreaCheckbox "Court Fines"
            , lawAreaCheckbox "Secured or Student Loans"
            , lawAreaCheckbox "Credit Card Debt"
            , lawAreaCheckbox "Overpaid Benefits Clawback"
            ]

        Housing ->
            [ lawAreaCheckbox "Allocations"
            , lawAreaCheckbox "Committals"
            , lawAreaCheckbox "Disrepair"
            , lawAreaCheckbox "Duty Scheme"
            , lawAreaCheckbox "Eviction"
            , lawAreaCheckbox "Homelessness"
            , lawAreaCheckbox "Homelessness Review"
            , lawAreaCheckbox "Injunction"
            , lawAreaCheckbox "Possession"
            ]

        ImmigrationAndAsylum ->
            [ lawAreaCheckbox "Asylum"
            , lawAreaCheckbox "Non-Asylum Immigration"
            , lawAreaCheckbox "Article 8"
            , lawAreaCheckbox "Article 3 / Humanitarian Protection"
            , lawAreaCheckbox "Domestic Violence"
            , lawAreaCheckbox "Family Reunion"
            , lawAreaCheckbox "NRPF"
            , lawAreaCheckbox "Trafficking"
            , lawAreaCheckbox "Children / UASC"
            ]

        Family ->
            [ lawAreaCheckbox "Care Proceedings"
            , lawAreaCheckbox "Child Abduction"
            , lawAreaCheckbox "Child Arrangement Orders"
            , lawAreaCheckbox "Divorce"
            , lawAreaCheckbox "Domestic Violence"
            , lawAreaCheckbox "Financial Matters"
            ]

        CommunityCare ->
            [ lawAreaCheckbox "Aids and Adaptations"
            , lawAreaCheckbox "Assessments for Care / Support"
            , lawAreaCheckbox "Best Interest Decision Making"
            , lawAreaCheckbox "Care / Support Planning"
            , lawAreaCheckbox "Care at Home"
            , lawAreaCheckbox "Care Home Placement / Supported Living"
            , lawAreaCheckbox "Carers Assessment / Services"
            , lawAreaCheckbox "Children's Act Assessment / Services"
            , lawAreaCheckbox "Payments (Charging, Personal Budget, Direct Payments)"
            , lawAreaCheckbox "Service Reorganisation / Closure"
            ]

        PublicLaw ->
            [ lawAreaCheckbox "Social Welfare"
            , lawAreaCheckbox "Human Rights"
            , lawAreaCheckbox "Migrant Support"
            , lawAreaCheckbox "Other"
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
