module Views.ListComments exposing (addCommentButton, commentActions, commentsHeader, commentsHeaderContent, likeText, listCommentsView, parentComment, replyComponent, showParentComment, singleComment, summary, summaryText)

import Components.ChooseTopic exposing (chooseTopic)
import Components.StyleHelpers exposing (bodyFont, buttonStyle, classes, displayElement, emptySpan, headlineFont, textareaFont, topicButtonFont)
import Data.Comment exposing (defaultComment, getCommentByCommentId, hasParentId)
import Data.CommentType exposing (commentTypeColor, commentTypeColorLight, commentTypes)
import Helpers exposing (ifThenElse, unionTypeToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


listCommentsView : Model -> Html Msg
listCommentsView model =
    div [ class "flex flex-column items-center w-80-ns w-90 center" ]
        [ div []
            [ div [ class "mv4" ] summary
            , div [ class "mv4" ] <| chooseTopic model
            , div [] (commentsHeader model)
            , div []
                (addCommentButton model
                    :: (List.map (singleComment model) <|
                            List.sortBy (.createdAt >> negate) <|
                                List.filter (\comment -> comment.commentType == model.commentType) model.comments
                       )
                )
            ]
        ]


summary : List (Html Msg)
summary =
    [ h1 [ classes [ headlineFont ] ] [ text "Check out what others have said" ]
    , p [ classes [ bodyFont, "mt2" ] ] [ text summaryText ]
    ]


summaryText : String
summaryText =
    """
    Here are the issues that Law Centres are seeing now, as shared by you! They are grouped by
    categories and the latest appear first. Feel free to reply to colleagues or simply 'like' their
    posts if they ring true. LCN responses to questions and requests are under the last heading.
    """


addCommentButton : Model -> Html Msg
addCommentButton model =
    a [ classes [ "dib link center flex flex-column items-center justify-center bg-near-white pointer br3 pv3 ma4 w-100" ], href "#add-comment" ]
        [ img [ src <| "./assets/add_" ++ commentTypeColor model.commentType ++ ".svg", classes [ "mb3", "h3 w3" ] ] []
        , div []
            [ span [ class "fw3 f3 black" ] [ text "Add your own " ]
            , span [ classes [ "fw7 f3", commentTypeColor model.commentType ] ] [ text <| String.toLower <| unionTypeToString model.commentType ]
            ]
        ]


commentsHeader : Model -> List (Html Msg)
commentsHeader model =
    [ h1 [ classes [ headlineFont, "" ] ] (commentsHeaderContent model) ]


commentsHeaderContent : Model -> List (Html Msg)
commentsHeaderContent model =
    case model.commentType of
        Success ->
            [ text "See what others have said about their "
            , span [ classes [ commentTypeColor Success, "b" ] ] [ text "successes" ]
            ]

        Annoyance ->
            [ text "Check out others' "
            , span [ classes [ commentTypeColor Annoyance, "b" ] ] [ text "annoyances" ]
            ]

        Trend ->
            [ text "See what "
            , span [ classes [ commentTypeColor Trend, "b" ] ] [ text "trends " ]
            , text "others have spotted"
            ]

        AskUs ->
            [ text "Have a look through "
            , span [ classes [ commentTypeColor AskUs, "b" ] ] [ text "questions " ]
            , text "others have asked"
            ]

        NoType ->
            []


singleComment : Model -> Comment -> Html Msg
singleComment model comment =
    let
        parentComment =
            getCommentByCommentId model (Maybe.withDefault "" comment.parentId)
    in
    div [ classes [ "center flex flex-column content-center bg-white br3 ph4 pt3 pb0 ma4" ] ]
        [ showParentComment model comment
        , div
            [ classes
                [ "mb3"
                , commentTypeColor model.commentType
                ]
            ]
            [ h1 [ classes [ "fw5", "f3", "b", "di" ] ] [ text <| ifThenElse (comment.name /= "") comment.name "Anonymous" ]
            , span [] [ text " - " ]
            , h1 [ classes [ "di", "fw3", "f3" ] ] [ text <| ifThenElse (comment.lawCentre /= NoCentre) (unionTypeToString comment.lawCentre ++ " Law Centre") "Law Centres Network" ]
            , ifThenElse (hasParentId comment)
                emptySpan
                (h2 [ class "di fw3 f3 i" ] [ text <| " - In reply to " ++ ifThenElse (parentComment.name /= "") parentComment.name "anonymous" ])
            ]
        , p [ classes [ "f4 lh-copy fw3", "mb3" ] ] [ text comment.commentBody ]
        , ifThenElse comment.showReplyInput (replyComponent comment) (commentActions model comment)
        ]


parentComment : Model -> Comment -> Html Msg
parentComment model comment =
    div
        [ classes
            [ "center flex flex-column content-center br3 pl3 pr4 pv3 mh4 mv3 w-100 bl bw3 overflow-scroll maxh5"
            , List.map (flip (++) (commentTypeColorLight model.commentType)) [ "bg-light-", "b--" ] |> List.intersperse " " |> List.foldr (++) ""
            ]
        ]
        [ div
            [ classes
                [ "mb3 lh-copy"
                , commentTypeColor model.commentType
                ]
            ]
            [ h1 [ classes [ "fw5", "f3", "di" ] ] [ text <| ifThenElse (comment.name /= "") comment.name "Anonymous" ]
            , span [] [ text " - " ]
            , h2 [ class "di fw3 f3" ] [ text <| unionTypeToString comment.lawCentre ++ " Law Centre" ]
            ]
        , p [ classes [ "f5 lh-copy fw3", "mb3" ] ] [ text comment.commentBody ]
        ]


commentActions : Model -> Comment -> Html Msg
commentActions model comment =
    let
        showReply =
            ifThenElse (model.commentType == AskUs && model.isAdmin == False)
                False
                True
    in
    div [ classes [ "flex", "content-center", "items-center", "h2", "mb3" ] ]
        [ button
            [ classes
                [ "pointer bn ph4 white f4 br2 mr3"
                , displayElement <| hasParentId comment && showReply
                , "bg-" ++ commentTypeColor comment.commentType
                ]
            , onClick <| ToggleReplyComponent comment
            ]
            [ text "reply" ]
        , img [ src <| "./assets/like-" ++ commentTypeColor comment.commentType ++ ".svg", classes [ "w2", "v-mid", "ml3", "h2", "w-15", ifThenElse comment.likedByUser "disableButton" "pointer" ], onClick <| UpvoteComment comment ] []
        , span [ classes [ commentTypeColor comment.commentType, "f4", "ml2 fw3", "dn", "di-ns" ] ] [ text <| likeText comment ]
        , span [ classes [ commentTypeColor comment.commentType, "f4", "ml2", "fw3", "dn-ns" ] ] [ text <| toString comment.likes ]
        ]


likeText : Comment -> String
likeText comment =
    case comment.likes of
        0 ->
            "Be the first person to like this"

        1 ->
            case comment.likedByUser of
                True ->
                    "You like this"

                False ->
                    "1 person likes this"

        _ ->
            case comment.likedByUser of
                True ->
                    "You and " ++ toString (comment.likes - 1) ++ " other people like this"

                False ->
                    toString comment.likes ++ " people like this"


replyComponent : Comment -> Html Msg
replyComponent parentComment =
    div [ classes [ "flex", "items-center", "bt", "bw1", "b--light-gray" ] ]
        [ img
            [ classes [ "w2", "h2" ]
            , src <| "./assets/comment-" ++ commentTypeColor parentComment.commentType ++ ".svg"
            ]
            []
        , textarea
            [ classes [ "bn mv3 pa3", "w-100", textareaFont ]
            , rows 1
            , placeholder "Write your comment here"
            , onInput UpdateCommentBody
            ]
            []
        , img
            [ classes [ "h2", "w2", "pointer", "dn-ns" ]
            , src <| "./assets/send-" ++ commentTypeColor parentComment.commentType ++ ".svg"
            , onClick <| PostReply parentComment
            ]
            []
        , button
            [ classes [ "bg-" ++ commentTypeColor parentComment.commentType, "dn-s", "white", "bn br2 pv2 ph3 f5" ]
            , onClick <| PostReply parentComment
            ]
            [ text "Send" ]
        ]


showParentComment : Model -> Comment -> Html Msg
showParentComment model comment =
    case comment.parentId of
        Just commentId ->
            parentComment model (getCommentByCommentId model commentId)

        Nothing ->
            emptySpan
