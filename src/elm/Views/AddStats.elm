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
                "Didn't work. Try again?"
                PostStats

        NotAsked ->
            bigColouredButton True "green" "Submit" ConfirmStats

        ResponseSuccess ->
            div [ class "f4 fw3 gray i" ] [ text "You have successfully sent your stats. See you next week!" ]


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
                    [ div [ class "mb3" ]
                        [ label [ for "lawArea", classes [ headlineFont, "mb1" ] ] [ text <| ifThenElse (model.postStatsStatus == ResponseSuccess || model.postStatsStatus == UserConfirmation) "The main kinds of problems you've seen this week:" "Tick the main kinds of problems you've seen this week:" ]
                        , h2 [ classes [ promptFont, "mt1", displayElement (model.postStatsStatus == NotAsked || model.postStatsStatus == ResponseFailure) ] ] [ text "(Please tick all that apply)" ]
                        ]
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
            [ problemCheckbox "Carers' Allowance" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Council Tax Reduction" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "DLA" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "ESA" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Entitlement" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "JSA" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Overpayment" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "PIP" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Pension Credit" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Right to Reside" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Sanctions" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Tax Credit" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Universal Credit" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        Employment ->
            [ problemCheckbox "Breach of Contract" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Constructive Dismissal" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Disciplinary / Grievance" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Discrimination" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Redundancy Payments" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Unfair Dismissal" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Whistleblowing" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Withheld Wages / Notice / Holiday Pay" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Working Time" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        Debt ->
            [ problemCheckbox "Council Tax Arrears / Bailiffs" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Court Fines" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Credit Card Debt" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Mortgage (Arrears or Interest Only)" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Overpaid Benefits Clawback" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Rent Arrears" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Secured or Student Loans" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Utilities" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        Housing ->
            [ problemCheckbox "Allocations" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Committals" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Disrepair" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Duty Scheme" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Eviction" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Homelessness" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Homelessness Review" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Injunction" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Possession" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        ImmigrationAndAsylum ->
            [ problemCheckbox "Article 3 / Humanitarian Protection" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Article 8" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Asylum" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Children / UASC" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Domestic Violence" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Family Reunion" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "NRPF" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Trafficking" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        Family ->
            [ problemCheckbox "Care Proceedings" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Child Abduction" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Child Arrangement Orders" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Divorce" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Domestic Violence" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Financial Matters" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        CommunityCare ->
            [ problemCheckbox "Aids and Adaptations" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Assessments for Care / Support" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Best Interest Decision Making" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Care / Support Planning" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Care Home Placement / Supported Living" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Care at Home" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Carers Assessment / Services" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Children's Act Assessment / Services" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Payments (Charging, Personal Budget, Direct Payments)" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Service Reorganisation / Closure" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        PublicLaw ->
            [ problemCheckbox "Human Rights" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Migrant Support" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Social Welfare" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        NoArea ->
            []
