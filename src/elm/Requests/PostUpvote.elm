module Requests.PostUpvote exposing (..)

import Http exposing (jsonBody, post)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (..)
import Json.Encode exposing (..)
import Types exposing (..)


postUpvote : String -> Cmd Msg
postUpvote commentId =
    Http.send ReceiveUpvoteStatus (upvoteRequest commentId)


upvoteRequest : String -> Http.Request UpvoteResponse
upvoteRequest commentId =
    post "/api/v1/upvote" (jsonBody <| upvote commentId) upvoteResponseDecoder


upvote : String -> Value
upvote commentId =
    object
        [ ( "comment_id", string commentId )
        ]


upvoteResponseDecoder : Decode.Decoder UpvoteResponse
upvoteResponseDecoder =
    decode UpvoteResponse
        |> required "success" Decode.bool
        |> required "commentId" Decode.string
        |> required "commentLikes" Decode.int
