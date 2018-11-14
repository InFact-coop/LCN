module Requests.PostStats exposing (postStats, stats, statsRequest, statsResponseDecoder)

import Helpers exposing (..)
import Http exposing (jsonBody, post)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, optional, required)
import Json.Encode exposing (..)
import Types exposing (..)


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


roleToStats : Model -> Role -> List ( String, Value )
roleToStats model role =
    case role of
        CaseWorker ->
            [ ( "Law area", string (unionTypeToString model.lawArea) )
            , ( "Client matters weekly", int model.clientMattersWeekly )
            , ( "New cases weekly", int model.newCasesWeekly )
            , ( "Problems encountered", list (List.map (\problem -> string problem) model.problems) )
            ]

        Management ->
            [ ( "Student volunteers weekly", int model.studentVolunteersWeekly )
            , ( "Lawyer volunteers weekly", int model.lawyerVolunteersWeekly )
            , ( "Vacancies weekly", int model.vacanciesWeekly )
            , ( "Media coverage weekly", int model.mediaCoverageWeekly )
            ]

        Triage ->
            [ ( "Enquiries weekly", int model.enquiriesWeekly )
            , ( "People signposted internally weekly", int model.signpostedInternallyWeekly )
            , ( "People referred to other agencies weekly", int model.signpostedExternallyWeekly )
            , ( "People turned away weekly", int model.peopleTurnedAwayWeekly )
            , ( "People with internal appointments weekly", int model.internalAppointmentsWeekly )
            , ( "Types of agencies referred to", list (List.map (\agency -> string agency) model.agencies) )
            ]

        NoRole ->
            []


rolesListToStats : Model -> List ( String, Value )
rolesListToStats model =
    List.map (\role -> roleToStats model role) model.roles |> List.concat


stats : Model -> Value
stats model =
    object <|
        [ ( "Name", string model.name )
        , ( "Law Centre", string (unionTypeToString model.lawCentre) )
        , ( "Job roles", list (List.map (\role -> string <| unionTypeToString role) model.roles) )
        ]
            ++ rolesListToStats model
