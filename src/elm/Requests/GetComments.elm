module Requests.GetComments exposing (..)

import Data.CommentType exposing (stringToCommmentType)
import Data.LawArea exposing (stringToLawArea)
import Data.LawCentre exposing (stringToLawCentre)
import Http exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Types exposing (..)


getCommentsRequest : Request (List Comment)
getCommentsRequest =
    Http.get "/api/v1/get-comments" (list commentDecoder)


commentDecoder : Decoder Comment
commentDecoder =
    decode Comment
        |> required "id" (maybe int)
        |> required "Parent Id" (maybe int)
        |> required "Name" string
        |> required "Law centre" (Json.Decode.map stringToLawCentre string)
        |> required "Comment body" string
        |> required "Likes" int
        |> required "Comment type" (Json.Decode.map stringToCommmentType string)
        |> required "Law area" (Json.Decode.map stringToLawArea string)
