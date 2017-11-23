module Components.Actions exposing (..)

import Components.Navbar exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


actionsPage : Model -> Html Msg
actionsPage model =
    div []
        [ h1 [] [ text "What would you like to do today" ]
        , div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView MadeMyDay ] [ text "Made My Day" ]
        , div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView Bug ] [ text "Bug bear" ]
        , div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView ISpy ] [ text "I-Spy" ]
        , div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView Snapshot ] [ text "Snapshot" ]
        ]
