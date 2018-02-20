module Views.AddStats exposing (..)

import Components.Button exposing (..)
import Components.LawArea exposing (lawAreaList, lawAreaOption)
import Components.LawAreaCheckbox exposing (lawAreaCheckbox)
import Components.StyleHelpers exposing (classes, displayElement)
import Data.LawArea exposing (decoderLawArea, stringToLawArea)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder, andThen)
import Types exposing (..)


addStatsView : Model -> Html Msg
addStatsView model =
    section
        [ class "flex justify-center h-100 pa3" ]
        [ section [ class "w-80" ]
            [ section [ class "mb5" ]
                [ h1 [ class "tl f2 fw5 black mb3" ] [ text "Introduction" ]
                , p [ class "fw3 f4" ] [ text "An intro into why LCN want this information etc etc" ]
                ]
            , section [ class "mb5" ]
                [ h1 [ class "tl f2 black mb4" ]
                    [ text "Weekly survey" ]
                , div
                    [ class "pl4" ]
                    [ h2 [ class "mb4 black f3 fw5 b" ]
                        [ text "What is your role?" ]
                    , div
                        []
                        (roleButtonsList model)
                    ]
                , div [ classes [ "pl4", "mt4", "mb5", displayElement <| model.role == CaseWorker ] ]
                    [ label [ for "lawArea", class "mb4 black f3 fw5 b" ] [ text "What is your primary area of Law?" ]
                    , select [ id "areaOfLaw", class "db f4 mt3 b--light-gray ba bw1 fw2 br4 pa2", placeholder "Immigration", on "change" <| Json.Decode.map UpdateLawArea targetValueDecoderLawArea ]
                        (List.map
                            lawAreaOption
                            lawAreaList
                        )
                    ]
                ]
            , section [ class "mb5" ]
                [ h1 [ class "tl f2 black mb4" ]
                    [ text "Your Week" ]
                , div [ class "pl4" ]
                    [ div
                        [ class "db mb4" ]
                        [ label [ for "peopleSeenWeekly", class "mb4 black f3 fw5 b" ]
                            [ text "How many people have you seen this week?" ]
                        , input [ id "peopleSeenWeekly", type_ "number", class "mt3 db br4 bw1 pa2 f3 ba b--light-gray", size 3, onInput UpdatePeopleSeen ] []
                        ]
                    , div
                        [ class "db mb4" ]
                        [ label [ for "peopleTurnedAwayWeekly", class "mb4 black f3 fw5 b" ]
                            [ text "How many people have you turned away this week?" ]
                        , input [ id "peopleTurnedAwayWeekly", type_ "number", class "mt3 db br4 bw1 pa2 f3 ba b--light-gray", size 3, onInput UpdatePeopleTurnedAway ] []
                        ]
                    ]
                , section [ class "mb5" ]
                    [ h1 [ class "tl f2 black mb4" ]
                        [ text "A bit more detail" ]
                    , div [ class "pl4" ]
                        [ h2 [ class "mb4 black f3 fw5 b" ]
                            [ text "What were the main kinds of problems you have seen this week? "

                            --, div [ class "fw3 i f4 lh-copy" ] [ text "Tick the top 3" ]
                            ]
                        , div [ class "mb1" ]
                            (lawAreaCheckboxesList model)
                        ]
                    ]
                ]
            , bigColouredButton "green" "Submit" PostStats
            ]
        ]


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
            [ colouredButton ("orange o-30 shrink") Triage
            , colouredButton ("green o-30 shrink") Management
            , colouredButton ("pink grow") CaseWorker
            ]

        Management ->
            [ colouredButton ("orange o-30 shrink") Triage
            , colouredButton ("green grow") Management
            , colouredButton ("pink o-30 shrink") CaseWorker
            ]

        Triage ->
            [ colouredButton ("orange grow") Triage
            , colouredButton ("green o-30 shrink") Management
            , colouredButton ("pink o-30 shrink") CaseWorker
            ]

        NoRole ->
            [ colouredButton ("orange o-30 shrink") Triage
            , colouredButton ("green o-30 shrink") Management
            , colouredButton ("pink o-30 shrink") CaseWorker
            ]


targetValueDecoderLawArea : Decoder LawArea
targetValueDecoderLawArea =
    targetValue
        |> andThen decoderLawArea
