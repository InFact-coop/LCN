module Routes.ThankYou exposing (..)

import Components.GrayButton exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


thankYou : Model -> Html Msg
thankYou model =
    section [ class "bg-light-blue h-100 m0-auto cover flex content-center items-center" ]
        [ article [ class "bg-white w-60-l w-75-m w-90 center h-auto tc br3 shadow-1" ]
            [ img [ src "./assets/send_modal.svg", class "h4 dark-gray bg-white br4 center tc justify-center minus-top-margin" ] []
            , h2 [ class "dark-gray tc pb4 raleway" ] [ text "Your application was sent successfully!" ]
            , img [ src "./assets/success.svg", class "h3 h4-ns" ] []
            , p [ class "lh-copy w-80 w-50-ns raleway fw1 tc center pv3 mid-gray" ]
                [ text "Done!"
                , br [] []
                , text "Your application has been sent to us and we will get back to you within 7 working days"
                ]
            , grayButton ( "Back to home", "home" )
            ]
        ]
