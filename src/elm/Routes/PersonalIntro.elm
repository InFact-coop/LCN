module Routes.PersonalIntro exposing (..)

import Components.Media exposing (..)
import Components.Questions exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (..)


personalIntro : Model -> Html Msg
personalIntro model =
    div []
        [ questionTemplate model
            ( "Q2: Please give us a small personal intro (60 second overview, hobbies, interests, what you enjoy outside of work)"
            , "next-role"
            )
        , a [ href "#thank-you", onClick SendForm ]
            [ div [ class "tc ma5" ] [ text "No thanks, I just want to send the form" ]
            ]
        , videoModal model
        , audioModal model
        ]
