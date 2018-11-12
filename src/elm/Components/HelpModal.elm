module Components.HelpModal exposing (helpModal)

import Components.StyleHelpers exposing (classes, displayElement)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


helpModal : Model -> Html Msg
helpModal model =
    section
        [ classes
            [ "modal fixed f3 ph5-ns ph4 pb3 pt4 bg-white br2 w-70-ns w-90 z-3 center tc content-box overflow-y-scroll overflow-y-visible-ns"
            , displayElement model.displayHelpModal
            ]
        ]
        [ img
            [ src "assets/help_icon_background.svg"
            , classes
                [ "db-ns"
                , "dn"
                , "help-icon-above"
                , "h4"
                , "w4"
                , "absolute"
                , "z-3"
                ]
            , alt "Help"
            ]
            []
        , img [ src "assets/cross.svg", class "h1d5 w1d5 absolute right-1d5 top-1d5 pointer", onClick ToggleHelpModal ] []
        , section [ class "tl" ]
            [ h1 [ classes [ "f2", "mb4", "mt3", "b" ] ] [ text "How do I use LCN's Data Tool?" ]
            , section [ class "fw3 f3" ]
                [ p [ class "mb3" ] [ text "Now you have logged in for the first time, you will go through a very short set-up." ]
                , p [ class "mb3" ] [ text "This is so that when you drop by next time, you will only be asked questions relevant to what you do, and as few of them as possible." ]
                , p [ class "mb3" ] [ text "The first part of the app asks how many cases you have worked on this week and what kinds. The point is not to need to go through your papers, just give your best estimate. These are just 3-4 simple questions that should take a minute to answer, anonymously." ]
                , p [ class "mb3" ] [ text "When you are done logging this, you will also see a ‘dashboard’ with the wider picture across Law Centres at the moment. At this point you can leave it there or continue to the next part." ]
                , p [ class "mb3" ] [ text "The second part lets you share more, this time using your name, about what you have seen during the week: what’s emerging? What has stood out? Others are sharing, too: you will be able to see what they have written, and comment on it\nHere you can also ask LCN to take up an issue you raise in its national policy work\nThe point is to help us all share what we see for maximum benefit – at minimum effort." ]
                ]
            ]
        ]
