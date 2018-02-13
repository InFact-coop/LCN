module Views.ListComments exposing (..)

import Html exposing (..)
import Types exposing (..)


listCommentsView : Model -> Html Msg
listCommentsView model =
    div [] [ text "Comment" ]
