module Components.LawAreaCheckbox exposing (agencyCheckbox, onCheckboxInput, problemCheckbox)

import Components.StyleHelpers exposing (bodyFont, checkboxFont, classes)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import Types exposing (..)


problemCheckbox : String -> Bool -> List String -> Html Msg
problemCheckbox content isDisabled checkedProblems =
    div [ classes [ "mb2 flex-row items-center", ifThenElse isDisabled "ml4" "", ifThenElse (List.member content checkedProblems || not isDisabled) "flex" "dn" ] ]
        [ input [ type_ "checkbox", id content, value content, classes [ "mr3 checked-pink", ifThenElse isDisabled "disableButton" "pointer", ifThenElse (List.member content checkedProblems && isDisabled) "dn" "" ], onCheckboxInput ToggleProblem ] []
        , label [ for content, classes [ ifThenElse isDisabled bodyFont checkboxFont, ifThenElse isDisabled "disableButton" "pointer" ] ] [ text content ]
        ]


agencyCheckbox : String -> Bool -> List String -> Html Msg
agencyCheckbox content isDisabled checkedAgencies =
    div [ classes [ "mb2 flex-row items-center", ifThenElse isDisabled "ml4" "", ifThenElse (List.member content checkedAgencies || not isDisabled) "flex" "dn" ] ]
        [ input [ type_ "checkbox", id content, value content, classes [ "mr3 checked-orange", ifThenElse isDisabled "disableButton dn" "pointer", ifThenElse isDisabled "dn" "" ], onCheckboxInput ToggleAgency ] []
        , label [ for content, classes [ ifThenElse isDisabled bodyFont checkboxFont, ifThenElse isDisabled "disableButton" "pointer" ] ] [ text content ]
        ]


onCheckboxInput : (String -> Bool -> msg) -> Html.Attribute msg
onCheckboxInput tagger =
    on "change" (Decode.map2 tagger targetValue targetChecked)
