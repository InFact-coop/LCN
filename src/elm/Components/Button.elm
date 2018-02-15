module Components.Button exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Helpers exposing (..)


colouredButton : String -> Role -> Html Msg
colouredButton colour role =
    button [ class <| "pointer bn br2 fw3 f4 pv3 mr4 ph3 white bg-" ++ colour, onClick <| UpdateRole role ] [ text <| unionTypeToLabel role ]


bigColouredButton : String -> String -> String -> Html Msg
bigColouredButton colour label linkTo =
    a [ class <| "dib link pointer bn br2 fw3 f3 pv3 mr4 ph4 white bg-" ++ colour, href linkTo ] [ text label ]
