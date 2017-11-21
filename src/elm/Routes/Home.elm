module Routes.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- import Html.Events exposing (..)

import Types exposing (..)


home : Model -> Html Msg
home model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "LCN" ]
        , a [ href "#repview" ] [ button [ class "f3 w60 mh1 tc" ] [ text "Continue as Rep" ] ]
        , a [ href "#workerview" ] [ button [ class "f3 w60 mh1 tc" ] [ text "Continue as Worker" ] ]

        -- , input [ class "f3 w30 pa1 center db ba tc", onInput Change, value model.userInput, placeholder "I update state, yo" ] []
        ]
