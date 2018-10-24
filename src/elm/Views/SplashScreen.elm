module Views.SplashScreen exposing (splashScreen)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


splashScreen : Model -> Html Msg
splashScreen model =
    section [ class "flex items-center justify-center w-100 vh-100" ]
        [ div
            [ class "ellipsis" ]
            [ div [ class "bg-pink w6-l h6-l h5-m w5-m w4 h4 mh4-ns mh3 br-100 dib bouncefade" ] []
            , div [ class "bg-orange w6-l h6-l h5-m w5-m w4 h4 mh4-ns mh3 br-100 dib bouncefade" ] []
            , div [ class "bg-green w6-l h6-l h5-m w5-m w4 h4 mh4-ns mh3 br-100 dib bouncefade" ] []
            ]
        ]
