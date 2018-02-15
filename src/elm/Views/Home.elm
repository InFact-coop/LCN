module Views.Home exposing (..)

import Data.LawCentre exposing (decoderLC)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder, andThen)
import Types exposing (..)


homeView : Model -> Html Msg
homeView model =
    section [ class "flex items-center justify-center h-100" ]
        [ section [ class "flex items-center justify-between flex-column bg-white pa3" ]
            [ img [ class "mb4", src "./assets/lcn-logo.png" ] []
            , div [ class "w-100 bb bw1 mb4 pb2 b--pink" ]
                [ label
                    [ for "name", class "b mr3" ]
                    [ text "Name:" ]
                , input [ id "name", class "f5 fw2 bn", size 35, type_ "text", placeholder "Larry Law", onInput UpdateName ] []
                ]
            , div [ class "w-100 bb bw1 mb4 pb2 b--orange" ]
                [ label
                    [ for "email", class "b mr3" ]
                    [ text "Email:" ]
                , input [ id "email", class "f5 fw2 bn", size 35, type_ "email", placeholder "larry.law@lawcentres.org" ] []
                ]
            , div [ class "w-100 bb bw1 mb4 pb2 b--blue" ]
                [ label
                    [ for "password", class "b mr3" ]
                    [ text "Password:" ]
                , input [ id "password", class "f5 fw2 bn", size 35, type_ "password", placeholder "lovethelaw" ] []
                ]
            , div [ class "w-100 bb bw1 mb4 pb2 b--green" ]
                [ label
                    [ for "lawcentre", class "b mr3" ]
                    [ text "Law Centre:" ]
                , select [ id "lawcentre", class "f5 fw2 bn", placeholder "Camden", on "change" <| Json.Decode.map UpdateLawCentre targetValueDecoderLC ]
                    [ option [ value <| toString Camden ] [ text <| toString Camden ]
                    , option [ value <| toString NoCentre ] [ text <| toString NoCentre ]
                    ]
                ]
            , a [ href "#numbers", class "link black dib bw1 f3 br3 ba b--black ph5 pv3 center" ] [ text "Login" ]
            ]
        ]


targetValueDecoderLC : Decoder LawCentre
targetValueDecoderLC =
    targetValue
        |> andThen decoderLC
