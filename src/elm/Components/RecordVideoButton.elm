module Components.RecordVideoButton exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (..)


recordVideoButton : Model -> Html Msg
recordVideoButton model =
    div [ class "w-50-ns w-100 mid-gray flex center flex-column mv2 pointer", onClick PrepareVideo ]
        [ img [ src "./assets/rec_video.svg", class "h5 mb2" ] []
        , text "Click to record video"
        ]
