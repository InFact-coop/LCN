module Components.AreaOfCare exposing (..)

import Components.Navbar exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


areaOfCarePage : Model -> Html Msg
areaOfCarePage model =
    div []
        [ h1 [] [ text "Choose your primary area of care" ]
        , div []
            [ div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView <| Dashboard ] [ text "Area 1" ] ]
        ]
