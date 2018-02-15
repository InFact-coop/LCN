module Components.Button exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)
import Helpers exposing (..)


colouredButton : String -> Role -> Html Msg
colouredButton colour role =
    button [ class <| "pointer bn br2 fw3 f4 pv3 mr4 ph3 white bg-" ++ colour ] [ text <| unionTypeToLabel role ]


bigColouredButton : String -> String -> Html Msg
bigColouredButton colour label =
    button [ class <| "pointer bn br2 fw3 f3 pv3 mr4 ph4 white bg-" ++ colour ] [ text label ]
