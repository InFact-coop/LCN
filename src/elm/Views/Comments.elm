module Views.Comments exposing (..)

import Html exposing (..)
import Types exposing (..)


commentsView : Model -> Html Msg
commentsView model =
    div [] [ text "Comment" ]
