module Routes.Home exposing (..)

import Components.GrayButton exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


home : Model -> Html Msg
home model =
    -- section [ class "bg-white w-40-ns w-90 h-auto tc center pv5 shadow-1 br3 " ]
    section [ class "bg-light-blue h-100 m0-auto cover flex content-center items-center" ]
        [ article [ class "bg-white w-40-l w-60-m w-90 center h-auto tc center br3 pt5 pb4 shadow-1" ]
            [ img [ src "./assets/logo_home.png", class "h4 tc center" ] []
            , p [ class "mid-gray lh-copy w-50-ns w-80 tc center fw3 pv3" ] [ text "So easy, you can interview for jobs in your sleep." ]
            , grayButton ( "Let's start!", "about-you" )
            ]
        ]
