module Requests.GetUserDetails exposing (..)

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
        |> optionalAt [ "fields", "law_centre" ] (Json.Decode.map stringToLawCentre string) NoCentre
        |> optionalAt [ "fields", "law_area" ] (Json.Decode.map stringToLawArea string) NoArea
        |> optionalAt [ "fields", "job_role" ] (Json.Decode.map stringToRole string) NoRole
