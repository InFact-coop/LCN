module Requests.PostNewUserDetails exposing (..)

import Http exposing (jsonBody, post)
import Json.Encode exposing (..)
import Json.Decode as Decode
import Types exposing (..)
import Types exposing (..)
import Helpers exposing (..)


postNewUserDetails : Model -> Cmd Msg
postNewUserDetails model =
    Http.send ReceiveUserDetailsStatus
        (userDetailsRequest model)


userDetailsRequest : Model -> Http.Request Bool
userDetailsRequest model =
    post "/api/v1/user-details" (jsonBody <| userDetails model) (Decode.field "success" Decode.bool)


userDetails : Model -> Value
userDetails model =
    object
        [ ( "law_centre", string (unionTypeToString model.lawCentre) )
        , ( "job_role", string (unionTypeToString model.role) )
        , ( "law_area", string (unionTypeToString model.lawArea) )
        ]
