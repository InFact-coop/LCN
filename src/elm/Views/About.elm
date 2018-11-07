module Views.About exposing (about)

import Components.Card exposing (card)
import Components.StyleHelpers exposing (classes, headlineFont)
import Helpers exposing (ifThenElse, unionTypeToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


about : Model -> Html Msg
about model =
    section
        [ classes [ "flex justify-center pa3-ns pv3", ifThenElse model.displayStatsModal "disableButton" "" ] ]
        [ section [ class "w-80-ns w-90" ]
            [ section [ class "w-90 center" ]
                [ section [ class "mb5" ]
                    [ h1 [ classes [ "tl mb3 f2 b" ] ] [ text "Thank you for signing up!" ]
                    ]
                , section [ class "mb4 f3" ]
                    [ p
                        [ classes [ "tl mb3" ] ]
                        [ text "Snapshot is the Law Centre Network app for capturing the kinds of cases we see, and the amount of work we do on them, and pooling them to give an overall picture." ]
                    , p
                        [ classes [ "tl mb3" ] ]
                        [ text "This will also help Law Centres talk about what we do in a more impactful way: giving an idea of the problems we see and how common they are, all on a current basis." ]
                    , p
                        [ classes [ "tl mb3" ] ]
                        [ text "As with most things, the more data we collect, the more useful it will be!" ]
                    ]
                ]
            , section [ class "flex flex-wrap justify-between" ]
                [ card "/assets/map-green.svg" "Get a local, regional and national picture of what Law Centres are dealing with"
                , card "/assets/network-blue.svg" "See how typical some problems are across Law Centres, without needing to email or ring around"
                , card "/assets/casework-pink.svg" "Help you make the case for your Law Centre's work, and funding it, with your council"
                , card "/assets/lobby-orange.svg" "Help LCN communicate and lobby on behalf of Law Centres faster and more effectively"
                ]
            ]
        ]
