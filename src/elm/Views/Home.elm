module Views.Home exposing (..)

import Html exposing (..)
import Types exposing (..)


homeView : Model -> Html Msg
homeView model =
    div [] [ text "Home" ]
