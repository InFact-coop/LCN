module Data.PostStats exposing (..)

import Http exposing (jsonBody, post)
import Json.Encode exposing (..)
import Json.Decode as Decode
import Types exposing (..)
import Helpers exposing (..)


postStats : Model -> Cmd Msg
postStats model =
    Http.send ReceiveStats
        (statsRequest model)


statsRequest : Model -> Http.Request Bool
statsRequest model =
    post "/api/v1/post-stats" (jsonBody <| stats model) (Decode.field "success" Decode.bool)


stats : Model -> Value
stats model =
    object
        [ ( "Name", string model.name )
        , ( "Law Centre", string (unionTypeToString model.lawCentre) )
        , ( "Law area", string (unionTypeToString model.lawArea) )
        , ( "People seen weekly", int model.peopleSeenWeekly )
        , ( "People turned away weekly", int (model.peopleTurnedAwayWeekly) )
        ]
