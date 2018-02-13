module Routes.ChallengingProject exposing (..)

import Components.Media exposing (..)
import Components.Questions exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


challengingProject : Model -> Html Msg
challengingProject model =
    div []
        [ questionTemplate model
            ( "Q3: What was the most challenging project you have worked on, and how did you contribute?"
            , "personal-intro"
            )
        , a [ href "#thank-you", onClick SendForm ]
            [ div [ class "tc ma5" ] [ text "No thanks, I just want to send the form" ]
            ]
        , videoModal model
        , audioModal model
        ]
