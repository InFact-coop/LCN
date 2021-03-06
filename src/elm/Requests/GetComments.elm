module Requests.GetComments exposing (commentDecoder, getComments, getCommentsRequest, handleGetComments)

import Data.CommentType exposing (stringToCommmentType)
import Data.LawArea exposing (stringToLawArea)
import Data.LawCentre exposing (stringToLawCentre)
import Http exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Navigation exposing (..)
import Router exposing (getView)
import Types exposing (..)


getComments : Cmd Msg
getComments =
    Http.send ReceiveComments getCommentsRequest


getCommentsRequest : Request (List Comment)
getCommentsRequest =
    Http.get "/api/v1/get-comments" (list commentDecoder)


commentDecoder : Decoder Comment
commentDecoder =
    decode Comment
        |> required "id" string
        |> optionalAt [ "fields", "Parent Id" ] (maybe string) Nothing
        |> optionalAt [ "fields", "Name" ] string ""
        |> optionalAt [ "fields", "Law centre" ] (Json.Decode.map stringToLawCentre string) NoCentre
        |> optionalAt [ "fields", "Comment body" ] string ""
        |> optionalAt [ "fields", "Likes" ] int 0
        |> optionalAt [ "fields", "Comment type" ] (Json.Decode.map stringToCommmentType string) Success
        |> optionalAt [ "fields", "Law area" ] (Json.Decode.map stringToLawArea string) NoArea
        |> required "createdTime" float
        |> hardcoded False
        |> requiredAt [ "fields", "likedByUser" ] bool


handleGetComments : Navigation.Location -> Cmd Msg
handleGetComments location =
    let
        currentView =
            getView location.hash
    in
    case currentView of
        ListComments ->
            getComments

        _ ->
            Cmd.none
