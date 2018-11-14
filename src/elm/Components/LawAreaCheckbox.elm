module Components.LawAreaCheckbox exposing (agencyCheckbox, onCheckboxInput, problemCheckbox)

import Components.StyleHelpers exposing (checkboxFont, classes)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import Types exposing (..)


problemCheckbox : String -> Bool -> Html Msg
problemCheckbox content isDisabled =
    div [ classes [ "mb2 flex flex-row items-center" ] ]
        [ input [ type_ "checkbox", id content, value content, classes [ "mr3", ifThenElse isDisabled "disableButton" "pointer" ], onCheckboxInput ToggleProblem ] []
        , label [ for content, classes [ checkboxFont, ifThenElse isDisabled "disableButton" "pointer" ] ] [ text content ]
        ]


agencyCheckbox : String -> Bool -> Html Msg
agencyCheckbox content isDisabled =
    div [ classes [ "mb2 flex flex-row items-center" ] ]
        [ input [ type_ "checkbox", id content, value content, classes [ "mr3", ifThenElse isDisabled "disableButton" "pointer" ], onCheckboxInput ToggleAgency ] []
        , label [ for content, classes [ checkboxFont, ifThenElse isDisabled "disableButton" "pointer" ] ] [ text content ]
        ]


onCheckboxInput : (String -> Bool -> msg) -> Html.Attribute msg
onCheckboxInput tagger =
    on "change" (Decode.map2 tagger targetValue targetChecked)
