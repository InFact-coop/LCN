module Requests.PostUpvote exposing (..)

import Http exposing (jsonBody, post)
import Json.Decode as Decode
import Json.Encode exposing (..)
import Types exposing (..)


postUpvote : String -> Cmd Msg
postUpvote commentId =
    Http.send ReceiveUpvoteStatus (upvoteRequest commentId)


upvoteRequest : String -> Http.Request Bool
upvoteRequest commentId =
    post "/api/v1/upvote" (jsonBody <| upvote commentId) (Decode.field "success" Decode.bool)


upvote : String -> Value
upvote commentId =
    object
        [ ( "Comment ID", string commentId )
        ]
