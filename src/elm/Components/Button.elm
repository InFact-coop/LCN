module Components.Button exposing (..)

import Components.StyleHelpers exposing (buttonStyle, classes, roleButtonFont, submitButtonStyle, topicButtonFont)
import Helpers exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


colouredButton : String -> Role -> Html Msg
colouredButton colour role =
    button
        [ classes
            [ "mr3 white w-25-ns w-100 mb2 mb0-ns"
            , "bg-" ++ colour
            , roleButtonFont
            , buttonStyle
            ]
        , onClick <| UpdateRole role
        ]
        [ text <| colouredButtonText role ]


colouredButtonText : Role -> String
colouredButtonText role =
    case role of
        CaseWorker ->
            "Lawyer/Case Worker"

        Triage ->
            "Triage/Reception"

        _ ->
            unionTypeToString role


bigColouredButton : Model -> String -> String -> Msg -> Html Msg
bigColouredButton model colour label clickMsg =
    button
        [ classes
            [ "mr4 white"
            , ifThenElse model.submitEnabled
                ("bg-" ++ colour)
                ("bg-gray disableButton o-30")
            , submitButtonStyle
            , topicButtonFont
            ]
        , onClick clickMsg
        ]
        [ text label ]


modalButton : String -> String -> Html Msg
modalButton label linkTo =
    a [ classes [ "dib", "link", "black", "pv2", "ph3", "ma2", "br4", "fw3", "f4", "ba", "b--light-gray", "bw1", "pointer" ], href linkTo, onClick ToggleStatsModal ] [ text label ]
