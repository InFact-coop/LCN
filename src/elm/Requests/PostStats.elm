module Requests.PostStats exposing (..)

import Http exposing (jsonBody, post)
import Json.Encode exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)
import Types exposing (..)
import Helpers exposing (..)


postStats : Model -> Cmd Msg
postStats model =
    Http.send ReceiveStats
        (statsRequest model)


statsResponseDecoder : Decode.Decoder StatsResponse
statsResponseDecoder =
    decode StatsResponse
        |> required "postSuccess" Decode.bool
        |> required "getSuccess" Decode.bool
        |> optional "peopleSeen" Decode.int 0


statsRequest : Model -> Http.Request StatsResponse
statsRequest model =
    post "/api/v1/post-stats" (jsonBody <| stats model) statsResponseDecoder


stats : Model -> Value
stats model =
    object
        [ ( "Name", string model.name )
        , ( "Law Centre", string (unionTypeToString model.lawCentre) )
        , ( "Law area", string (unionTypeToString model.lawArea) )
        , ( "People seen weekly", int model.peopleSeenWeekly )
        , ( "People turned away weekly", int (model.peopleTurnedAwayWeekly) )
        , ( "Problems encountered", list (List.map (\problem -> string problem) model.problems) )
        ]
