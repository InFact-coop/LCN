module Views.Home exposing (..)

import Components.LawCentre exposing (lawCentreList, lawCentreOption)
import Components.StyleHelpers exposing (classes, inputFont, inputLabelFont)
import Data.LawCentre exposing (decoderLC, stringToLawCentre)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder, andThen)
import Types exposing (..)


homeView : Model -> Html Msg
homeView model =
    section [ class "flex items-center justify-center vh-100" ]
        [ section [ class "flex items-center justify-between flex-column bg-white pa5-ns pa2 pv4" ]
            [ img [ class "mb4", src "./assets/lcn-logo.png" ] []
            , div [ class "w-100-ns w-90 bb bw1 mb4 pb2 b--pink" ]
                [ label
                    [ for "name", classes [ "mr3", inputLabelFont ] ]
                    [ text "Name:" ]
                , input [ id "name", classes [ inputFont, "bn w-75" ], type_ "text", placeholder "Larry Law", onInput UpdateName ] []
                ]
            , div
                [ class "w-100-ns w-90 bb bw1 mb4 pb2 b--orange"
                ]
                [ label
                    [ for "email", classes [ "mr3", inputLabelFont ] ]
                    [ text "Email:" ]
                , input [ id "email", classes [ inputFont, "bn w-75" ], type_ "email", placeholder "larry.law@lawcentres.org" ] []
                ]
            , div [ class "w-100-ns w-90 bb bw1 mb4 pb2 b--blue" ]
                [ label
                    [ for "password", classes [ "mr3", inputLabelFont ] ]
                    [ text "Password:" ]
                , input [ id "password", classes [ inputFont, "bn w-70-ns w-60" ], type_ "password", placeholder "lovethelaw" ] []
                ]
            , div [ class "w-100-ns w-90 bb bw1 mb4 pb2 b--green" ]
                [ label
                    [ for "lawcentre", classes [ "mr3", inputLabelFont ] ]
                    [ text "Law Centre:" ]
                , select [ id "lawcentre", classes [ inputFont, "bn" ], placeholder "Camden", on "change" <| Json.Decode.map UpdateLawCentre targetValueDecoderLC ]
                    (List.map lawCentreOption lawCentreList)
                ]
            , a [ href "#numbers", classes [ "link dib bw1 f3 br3 ba ph5 pv3 center", ifThenElse (model.submitEnabled == True) "black b--black" "light-gray b--light-gray disableButton" ] ] [ text "Log in" ]
            ]
        ]


targetValueDecoderLC : Decoder LawCentre
targetValueDecoderLC =
    targetValue
        |> andThen decoderLC
