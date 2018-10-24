module Requests.GetUserDetails exposing (getUserDetails, getUserDetailsRequest, userDetailsDecoder)

import Data.LawArea exposing (stringToLawArea)
import Data.LawCentre exposing (stringToLawCentre)
import Data.Role exposing (stringToRole)
import Http exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Types exposing (..)


getUserDetails : Cmd Msg
getUserDetails =
    Http.send GetUserDetailsStatus getUserDetailsRequest


getUserDetailsRequest : Request UserDetails
getUserDetailsRequest =
    Http.get "/api/v1/user-details" userDetailsDecoder


userDetailsDecoder : Decoder UserDetails
userDetailsDecoder =
    decode UserDetails
        |> required "full_name" string
        |> optional "law_centre" (Json.Decode.map stringToLawCentre string) NoCentre
        |> optional "law_area" (Json.Decode.map stringToLawArea string) NoArea
        |> optional "job_role" (Json.Decode.map (List.map stringToRole) (list string)) [ NoRole ]
        |> required "admin" bool
