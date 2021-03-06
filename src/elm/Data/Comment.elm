module Data.Comment exposing
    ( defaultComment
    , getCommentByCommentId
    , hasParentId
    , toggleReplyComponent
    , updateCommentLikes
    )

import Helpers exposing (ifThenElse)
import Types exposing (..)


defaultComment : Comment
defaultComment =
    Comment "" Nothing "" NoCentre "" 0 NoType NoArea 0 False False


toggleReplyComponent : Model -> Comment -> List Comment
toggleReplyComponent model clickedComment =
    List.map
        (\currentComment ->
            ifThenElse (currentComment.id == clickedComment.id)
                { currentComment | showReplyInput = not currentComment.showReplyInput }
                { currentComment | showReplyInput = False }
        )
        model.comments


getCommentByCommentId : Model -> CommentId -> Comment
getCommentByCommentId model commentId =
    List.filter (\comment -> comment.id == commentId) model.comments
        |> List.head
        |> Maybe.withDefault defaultComment


hasParentId : Comment -> Bool
hasParentId comment =
    case comment.parentId of
        Just _ ->
            False

        Nothing ->
            True


updateCommentLikes : UpvoteResponse -> Comment -> Comment
updateCommentLikes upvote comment =
    { comment
        | likes =
            ifThenElse (comment.id == upvote.commentId)
                upvote.commentLikes
                comment.likes
        , likedByUser =
            ifThenElse
                (comment.id
                    == upvote.commentId
                    || comment.likedByUser
                    == True
                )
                True
                False
    }
