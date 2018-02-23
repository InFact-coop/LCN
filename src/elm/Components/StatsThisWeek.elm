module Components.StatsThisWeek exposing (..)

import Components.LawAreaCheckbox exposing (problemCheckbox, agencyCheckbox)
import Components.StyleHelpers exposing (bodyFont, classes, displayElement, headlineFont)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


statsThisWeek : Model -> Html Msg
statsThisWeek model =
    let
        peopleSeenText =
            ifThenElse (model.role == CaseWorker)
                "How many cases have you seen this week in total?"
                "How many enquiries have you had this week in all? (include phone, email, in person)"
    in
        section [ class "mb4 mt4" ]
            [ h1 [ classes [ "tl mb2", headlineFont ] ]
                [ text "Your Week" ]
            , h2 [ classes [ "tl mb4 i fw3" ] ] [ text "If you don't remember exactly, give us your best estimate" ]
            , div []
                [ numericalInput True peopleSeenText UpdatePeopleSeen
                , numericalInput (model.role == CaseWorker) "Of these, how many cases were new (even with a returning client)?" UpdateNewCases
                , numericalInput (model.role == Triage) "How many enquiries have you had to turn away without signposting anywhere?" UpdatePeopleTurnedAway
                , numericalInput (model.role == Triage) "How many enquiries were signposted to one-off Law Centre advice? (include drop in or pro bono clinics)" UpdateSignpostedInterally
                , numericalInput (model.role == Triage) "How many enquiries were referred to other agencies?" UpdateSignpostedExternally
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


numericalInput : Bool -> String -> (String -> Msg) -> Html Msg
numericalInput shouldDisplay labelContent msg =
    div
        [ classes [ "mb4", displayElement shouldDisplay ] ]
        [ label [ for <| toString msg, classes [ "mb4", bodyFont ] ]
            [ text labelContent ]
        , input [ id <| toString msg, type_ "number", class "mt3 db br4 bw1 pa2 f3 ba b--light-gray", size 3, onInput msg ] []
        ]
