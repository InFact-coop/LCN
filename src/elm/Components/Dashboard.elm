module Components.Dashboard exposing (..)

import Components.Navbar exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


dashboardPage : Model -> Html Msg
dashboardPage model =
    div []
        [ h1 [] [ text "What would you like to do today" ]
        , div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView Success ] [ text "Success" ]
        , div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView Bug ] [ text "Bug" ]
        , div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView Help ] [ text "Help" ]
        , div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView Suggest ] [ text "Suggest" ]
        ]
