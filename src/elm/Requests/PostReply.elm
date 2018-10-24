module Requests.PostReply exposing (comment, postReply, replyRequest)

import Helpers exposing (unionTypeToString)
import Http exposing (jsonBody, post)
import Json.Decode as Decode
import Json.Encode exposing (..)
import Types exposing (..)


postReply : Model -> Comment -> Cmd Msg
postReply model parentComment =
    Http.send ReceiveCommentStatus (replyRequest model parentComment)


replyRequest : Model -> Comment -> Http.Request Bool
replyRequest model parentComment =
    post "/api/v1/post-comment" (jsonBody <| comment model parentComment) (Decode.field "success" Decode.bool)


comment : Model -> Comment -> Value
comment model parentComment =
    object
        [ ( "Name", string model.name )
        , ( "Law centre", string (unionTypeToString model.lawCentre) )
        , ( "Comment body", string model.commentBody )
        , ( "Comment type", string (unionTypeToString parentComment.commentType) )
        , ( "Law area", string (unionTypeToString parentComment.lawArea) )
        , ( "Parent Id", string parentComment.id )
        ]
