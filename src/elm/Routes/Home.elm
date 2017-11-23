module Routes.Home exposing (..)

-- import Html.Events exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


home : Model -> Html Msg
home model =
    div [ class "center" ]
        [ h1 [ class "tc f1" ] [ text "LCN" ]
        , a [ href "#repview", class "f3 tc bg-white link ba br2 bw5 pa2 ma2 b--pink" ] [ text "Continue as Rep" ]
        , a [ href "#workerview", class "f3 tc bg-white link ba br2 bw5 pa2 ma2 b--blue", onClick <| UpdateFormView AreaOfCare ] [ text "Continue as Worker" ]
        ]
