module Data.PostComment exposing (..)

import Http exposing (jsonBody, post)
import Json.Encode exposing (..)
import Json.Decode as Decode
import Types exposing (..)
import Views.AddComment exposing (commentTypeToString)


postComment : Model -> Cmd Msg
postComment model =
    Http.send ReceiveCommentStatus (commentRequest model)


commentRequest : Model -> Http.Request String
commentRequest model =
    post "/post-comment" (jsonBody <| comment model) (Decode.succeed "")


comment : Model -> Value
comment model =
    object
        [ ( "Name", string model.name )
        , ( "Law centre", string (lawCentreToString model.lawCentre) )
        , ( "Comment body", string model.commentBody )
        , ( "Comment type", string (commentTypeToString model.commentType) )
        , ( "Law area", string (lawAreaToString model.lawArea) )
        ]


lawCentreToString : LawCentre -> String
lawCentreToString lawCentre =
    case lawCentre of
        Camden ->
            "Camden"

        NoCentre ->
            "No Centre"


lawAreaToString : LawArea -> String
lawAreaToString lawArea =
    case lawArea of
        Criminal ->
            "Criminal"

        Immigration ->
            "Immigration"

        NoArea ->
            "No Area"



-- type alias Comment =
--     { id : Maybe Int
--     , parentId : Maybe Int
--     , name : String
--     , lawCentre : Maybe LawCentre
--     , commentBody : String
--     , likes : Int
--     , commentType : Maybe CommentType
--     , lawArea : Maybe LawArea
--     }
