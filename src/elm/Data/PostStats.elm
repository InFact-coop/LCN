module Data.PostStats exposing (..)

import Http exposing (jsonBody, post)
import Json.Encode exposing (..)
import Json.Decode as Decode
import Types exposing (..)


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
        , ( "Law centre", string (lawCentreToString model.lawCentre) )
        , ( "Law area", string (lawAreaToString model.lawArea) )
        , ( "People seen weekly", int model.peopleSeenWeekly )
        , ( "People turned away weekly", int (model.peopleTurnedAwayWeekly) )
        ]


lawCentreToString : LawCentre -> String
lawCentreToString lawCentre =
    case lawCentre of
        Camden ->
            "Camden"

        NoCentre ->
            "No Centre"


lawAreaToString : LawArea -> String
lawAreaToString lawArea =
    case lawArea of
        Criminal ->
            "Criminal"

        Immigration ->
            "Immigration"

        NoArea ->
            "No Area"
