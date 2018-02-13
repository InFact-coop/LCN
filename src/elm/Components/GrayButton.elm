module Components.GrayButton exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


grayButton : ( String, String ) -> Html Msg
grayButton ( name, route ) =
    a
        [ href ("#" ++ route), class "center tc no-underline fw1" ]
        [ div [ class "white w-30-l w-40-m w-60 bg-gray fw2 center mv4 pa3 br4 fw1 f5 no-underline open-sans" ] [ text name ]
        ]
