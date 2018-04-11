module Views.SplashScreen exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


splashScreen : Model -> Html Msg
splashScreen model =
    section [ class "flex items-center justify-center" ]
        [ img [ src "./assets/lcn-logo.png" ] []
        ]
