module Routes.NextRole exposing (..)

import Components.Media exposing (..)
import Components.Questions exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (..)


nextRole : Model -> Html Msg
nextRole model =
    div []
        [ questionTemplate model
            ( "Q1: What are you looking for in your next role?"
            , "about-you"
            )
        , a [ href "#thank-you", onClick SendForm ]
            [ div [ class "tc ma5" ] [ text "No thanks, I just want to send the form" ]
            ]
        , videoModal model
        , audioModal model
        ]
