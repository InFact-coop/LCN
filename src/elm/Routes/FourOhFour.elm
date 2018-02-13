module Routes.FourOhFour exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


fourohfour : Model -> Html Msg
fourohfour model =
    div [ class "home" ] [ a [ href "#home" ] [ text "Sorry, we can't find that page! Click here to go back home" ] ]
