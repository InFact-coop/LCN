module Routes.RepView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


repView : Model -> Html Msg
repView model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "Rep Page" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "I'm gunna be a pic" ]
        ]
