module Components.LawAreaCheckbox exposing (..)

import Components.StyleHelpers exposing (checkboxFont, classes)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import Types exposing (..)


problemCheckbox : String -> Html Msg
problemCheckbox content =
    div [ classes [ "mb2 flex flex-row items-center" ] ]
        [ input [ type_ "checkbox", id content, value content, classes [ "mr3", "pointer" ], onCheckboxInput ToggleProblem ] []
        , label [ for content, classes [ checkboxFont, "pointer" ] ] [ text content ]
        ]


agencyCheckbox : String -> Html Msg
agencyCheckbox content =
    div [ classes [ "mb2 flex flex-row items-center" ] ]
        [ input [ type_ "checkbox", id content, value content, classes [ "mr3", "pointer" ], onCheckboxInput ToggleAgency ] []
        , label [ for content, classes [ checkboxFont, "pointer" ] ] [ text content ]
        ]


onCheckboxInput : (String -> Bool -> msg) -> Html.Attribute msg
onCheckboxInput tagger =
    on "change" (Decode.map2 tagger targetValue targetChecked)
