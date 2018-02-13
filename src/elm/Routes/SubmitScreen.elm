module Routes.SubmitScreen exposing (..)

import Components.Media exposing (..)
import Components.Questions exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


submitScreen : Model -> Html Msg
submitScreen model =
    section [ class "bg-light-blue m0-auto cover" ]
        [ header []
            [ h1 [ class "tc dark-gray raleway fw2 pa5-ns pa4 f2 m0-auto" ] [ text "In your own words" ]
            ]
        , a [ href ("#challenging-project"), class "no-underline" ]
            [ div [ class "w-60-l w-90 w-75-m center mid-gray fw1 raleway mb2" ]
                [ img [ src "./assets/back.svg", class "h1 mr2" ] []
                , text "Go Back"
                ]
            ]
        , section [ class "w-60-l w-90 w-75-m center bg-white br3 shadow-1 pb5 pt3" ]
            [ article [ class " w-90 center pv1" ]
                [ h2 [ class "mid-gray raleway" ] [ text "Thank you for finishing your application!" ]
                , h3 [] [ text "Please click submit to send off your application" ]
                , img [ src "./assets/recording_stopped.svg" ] []
                ]
            ]
        , div [ class "pointer white w-30-l w-40-m w-60 bg-green fw2 center mv4 pa3 br4 fw1 f5 no-underline open-sans tc", onClick SendForm ] [ text "Submit" ]
        ]
