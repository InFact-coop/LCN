module Requests.PostComment exposing (..)

import Data.CommentType exposing (commentTypeToString)
import Data.LawCentre exposing (lawCentreToString)
import Http exposing (jsonBody, post)
import Json.Decode as Decode
import Json.Encode exposing (..)
import Types exposing (..)


postComment : Model -> Cmd Msg
postComment model =
    Http.send ReceiveCommentStatus (commentRequest model)


commentRequest : Model -> Http.Request Bool
commentRequest model =
    post "/api/v1/post-comment" (jsonBody <| comment model) (Decode.field "success" Decode.bool)


comment : Model -> Value
comment model =
    object
        [ ( "Name", string model.name )
        , ( "Law centre", string (lawCentreToString model.lawCentre) )
        , ( "Comment body", string model.commentBody )
        , ( "Comment type", string (commentTypeToString model.commentType) )
        , ( "Law area", string (lawAreaToString model.lawArea) )
        ]


lawAreaToString : LawArea -> String
lawAreaToString lawArea =
    case lawArea of
        Criminal ->
            "Criminal"

        Immigration ->
            "Immigration"

        NoArea ->
            "No Area"
