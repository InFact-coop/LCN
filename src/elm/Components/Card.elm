module Components.Card exposing (card)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


card : String -> String -> Html Msg
card imgsrc copy =
    div [ class "shadow-4 w-45 mb5 bg-white ph4 pv4 flex flex-column items-center" ]
        [ img [ class "h3", src imgsrc ]
            []
        , div [ class "pv3" ]
            [ text copy ]
        ]
