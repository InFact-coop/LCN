module Requests.PostNewUserDetails exposing (..)

import Http exposing (jsonBody, post)
import Json.Encode exposing (..)
import Json.Decode as Decode
import Types exposing (..)


-- import Json.Decode.Pipeline exposing (decode, required, optional)

import Types exposing (..)
import Helpers exposing (..)


postNewUserDetails : Model -> Cmd Msg
postNewUserDetails model =
    Http.send ReceiveUserDetailsStatus
        (userDetailsRequest model)


userDetailsRequest : Model -> Http.Request Bool
userDetailsRequest model =
    post "/user-details" (jsonBody <| userDetails model) (Decode.field "success" Decode.bool)


userDetails : Model -> Value
userDetails model =
    object
        [ ( "Law Centre", string (unionTypeToString model.lawCentre) )
        , ( "Job Role", string (unionTypeToString model.role) )
        , ( "Law Area", string (unionTypeToString model.lawArea) )
        ]
