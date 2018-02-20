module Components.Button exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Helpers exposing (..)
import Components.StyleHelpers exposing (classes)


colouredButton : String -> Role -> Html Msg
colouredButton colour role =
    let
        buttonText =
            ifThenElse (role == CaseWorker) "Lawyer/Case Worker" (unionTypeToString role)
    in
        button [ class <| "pointer bn br2 fw3 f4 pv3 mr4 ph3 white bg-" ++ colour, onClick <| UpdateRole role ] [ text buttonText ]


bigColouredButton : String -> String -> Msg -> Html Msg
bigColouredButton colour label clickMsg =
    button [ class <| "pointer bn br2 fw3 f3 pv3 mr4 ph4 white bg-" ++ colour, onClick clickMsg ] [ text label ]


modalButton : String -> String -> Html Msg
modalButton label linkTo =
    a [ classes [ "dib", "link", "black", "pv2", "ph3", "ma2", "br4", "fw3", "f4", "ba", "b--light-gray", "bw1", "pointer" ], href linkTo, onClick ToggleStatsModal ] [ text label ]
