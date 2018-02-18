module Components.StyleHelpers exposing (..)

import Html.Attributes exposing (..)
import Html exposing (..)


headlineFont : String
headlineFont =
    "f3 lh-copy black b"


bodyFont : String
bodyFont =
    "f4 lh-copy black"


buttonStyle : String
buttonStyle =
    "pointer link lh-copy bn br2"


classes : List String -> Html.Attribute msg
classes classList =
    String.join " " classList
        |> class


emptyDiv : Html msg
emptyDiv =
    div [ class "dn" ] []


displayElement : Bool -> String
displayElement bool =
    if bool then
        ""
    else
        "dn"
