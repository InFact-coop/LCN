module Requests.PostStats exposing (..)

import Http exposing (jsonBody, post)
import Json.Encode exposing (..)
import Json.Decode as Decode
import Json.Encode.Extra exposing (maybe)
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
        , ( "People seen weekly", maybe int model.peopleSeenWeekly )
        , ( "Volunteers weekly", maybe int model.volunteersTotalWeekly )
        , ( "Student volunteers weekly", maybe int model.studentVolunteersWeekly )
        , ( "Lawyer volunteers weekly", maybe int model.lawyerVolunteersWeekly )
        , ( "Vacancies weekly", maybe int model.vacanciesWeekly )
        , ( "Media coverage weekly", maybe int model.mediaCoverageWeekly )
        , ( "People turned away weekly", maybe int model.peopleTurnedAwayWeekly )
        , ( "New cases weekly", maybe int model.newCasesWeekly )
        , ( "People signposted internally weekly", maybe int model.signpostedInternallyWeekly )
        , ( "People referred to other agencies weekly", maybe int model.signpostedExternallyWeekly )
        , ( "Problems encountered", list (List.map (\problem -> string problem) model.problems) )
        , ( "Types of agencies referred to", list (List.map (\agency -> string agency) model.agencies) )
        ]
