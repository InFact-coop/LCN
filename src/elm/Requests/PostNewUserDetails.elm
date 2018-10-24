module Requests.PostNewUserDetails exposing (postNewUserDetails, userDetails, userDetailsRequest)

import Helpers exposing (..)
import Http exposing (jsonBody, post)
import Json.Decode as Decode
import Json.Encode exposing (..)
import Types exposing (..)


postNewUserDetails : Model -> Cmd Msg
postNewUserDetails model =
    Http.send PostUserDetailsStatus
        (userDetailsRequest model)


userDetailsRequest : Model -> Http.Request Bool
userDetailsRequest model =
    post "/api/v1/user-details" (jsonBody <| userDetails model) (Decode.field "success" Decode.bool)


userDetails : Model -> Value
userDetails model =
    object
        [ ( "law_centre", string (unionTypeToString model.lawCentre) )
        , ( "job_role", list (List.map (unionTypeToString >> string) model.role) )
        , ( "law_area", string (unionTypeToString model.lawArea) )
        ]
