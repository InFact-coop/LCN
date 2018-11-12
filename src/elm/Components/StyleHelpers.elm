module Components.StyleHelpers exposing (bodyFont, buttonStyle, checkboxFont, classes, displayElement, emptySpan, headlineFont, inputFont, inputLabelFont, navLinkFont, navLinkStyle, promptFont, roleButtonFont, submitButtonStyle, textareaFont, topicButtonFont)

import Html exposing (..)
import Html.Attributes exposing (..)


headlineFont : String
headlineFont =
    "f3 fw6"


bodyFont : String
bodyFont =
    "f4 lh-copy fw3"


promptFont : String
promptFont =
    "f5 fw3"


checkboxFont : String
checkboxFont =
    "f5 lh-copy fw3"


topicButtonFont : String
topicButtonFont =
    "f3 fw3"


roleButtonFont : String
roleButtonFont =
    "f4 fw3"


inputLabelFont : String
inputLabelFont =
    "fw5 f4"


inputFont : String
inputFont =
    "fw3 f4"


submitButtonStyle : String
submitButtonStyle =
    "bn br2 pv3 ph3 w5 white"


textareaFont : String
textareaFont =
    "f5 lh-copy black"


navLinkFont : String
navLinkFont =
    "black f4"


navLinkStyle : String
navLinkStyle =
    "link pointer nav pb2"


buttonStyle : String
buttonStyle =
    "pointer bn br2 pv3 ph3"


classes : List String -> Html.Attribute msg
classes classList =
    String.join " " classList
        |> class


emptySpan : Html msg
emptySpan =
    span [ class "dn" ] []


displayElement : Bool -> String
displayElement bool =
    if bool then
        ""

    else
        "dn"
