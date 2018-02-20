module Views.ListComments exposing (..)

import Components.StyleHelpers exposing (bodyFont, buttonStyle, classes, displayElement, emptyDiv, headlineFont, textareaFont)
import Data.Comment exposing (defaultComment, getCommentByCommentId, hasParentId)
import Data.CommentType exposing (commentTypeColor, commentTypes)
import Helpers exposing (ifThenElse, unionTypeToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


listCommentsView : Model -> Html Msg
listCommentsView model =
    div [ class "flex flex-column items-center" ]
        [ div []
            [ div [ class "mv3" ] summary
            , div [ class "mv3" ] chooseTopic
            , div [] (commentsHeader model)
            , div []
                (List.map (singleComment model) <|
                    List.sortBy (.createdAt >> negate) <|
                        List.filter (\comment -> comment.commentType == model.commentType) model.comments
                )
            ]
        ]


summary : List (Html Msg)
summary =
    [ h1 [ classes [ headlineFont ] ] [ text "Summary" ]
    , p [ classes [ bodyFont ] ] [ text "An intro to this section could go here. Explaining that it's optional and why the information is useful" ]
    ]


chooseTopic : List (Html Msg)
chooseTopic =
    [ h1 [ classes [ headlineFont, "" ] ] [ text "Choose a topic" ]
    , div [ class "flex justify-between mt2" ]
        (List.map
            topicButton
            commentTypes
        )
    ]


topicButton : CommentType -> Html Msg
topicButton commentType =
    button
        [ classes
            [ "ph3 pv2 w5 white"
            , bodyFont
            , buttonStyle
            , "bg-" ++ (commentTypeColor (commentType))
            ]
        , onClick <| UpdateCommentType commentType
        ]
        [ text <| unionTypeToString commentType ]


commentsHeader : Model -> List (Html Msg)
commentsHeader model =
    [ h1 [ classes [ headlineFont, "" ] ] (commentsHeaderContent model) ]


commentsHeaderContent : Model -> List (Html Msg)
commentsHeaderContent model =
    case model.commentType of
        Success ->
            [ text "See what others have said about their "
            , span [ classes [ (commentTypeColor Success), "b" ] ] [ text "successes" ]
            ]

        Annoyance ->
            [ text "Check out others' "
            , span [ classes [ (commentTypeColor Annoyance), "b" ] ] [ text "annoyances" ]
            ]

        Trend ->
            [ text "See what "
            , span [ classes [ (commentTypeColor Trend), "b" ] ] [ text "trends " ]
            , text "others have spotted"
            ]

        AskUs ->
            [ text "Have a look through "
            , span [ classes [ (commentTypeColor AskUs), "b" ] ] [ text "questions " ]
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
        div [ classes [ "center", "flex", "flex-column", "content-center", "bg-white", "br3", "ph4", "pt3", "pb0", "ma4" ] ]
            [ showParentComment model comment
            , div [ classes [ "green", "mb3" ] ]
                [ h1 [ classes [ "fw5", "f3", "b", "di" ] ] [ text comment.name ]
                , span [] [ text " - " ]
                , h1 [ classes [ "di", "fw3", "f3" ] ] [ text <| (unionTypeToString comment.lawCentre) ++ " Law Centre" ]
                , ifThenElse (hasParentId comment)
                    emptyDiv
                    (h2 [ class "di fw3 f3 i" ] [ text <| " - In reply to " ++ parentComment.name ])
                ]
            , p [ classes [ "fw3", "lh-copy", "mb3" ] ] [ text comment.commentBody ]
            , ifThenElse comment.showReplyInput (replyComponent comment) (commentActions comment)
            ]


commentActions : Comment -> Html Msg
commentActions comment =
    div [ classes [ "flex", "content-center", "h2", "mb3" ] ]
        [ button
            [ classes
                [ "pointer"
                , "bn"
                , "bg-green"
                , "ph4"
                , "white"
                , "f4"
                , "br1"
                , "mr3"
                , displayElement <| hasParentId comment
                ]
            , onClick <| ToggleReplyComponent comment
            ]
            [ text "reply" ]
        , img [ src "./assets/like.svg", classes [ "w2", "v-mid" ] ] []
        ]


replyComponent : Comment -> Html Msg
replyComponent parentComment =
    div [ classes [ "flex", "items-center", "bt", "bw1", "b--light-gray" ] ]
        [ img [ classes [ "w2", "h2" ], src "./assets/comment.svg" ] []
        , textarea
            [ classes [ "bn mv3 pa3", "w-100", textareaFont ]
            , rows 1
            , placeholder "Write your comment here"
            , onInput UpdateCommentBody
            ]
            []
        , img [ classes [ "h2", "w2", "pointer" ], src "./assets/send.svg", onClick <| PostReply parentComment ] []
        ]


parentComment : Model -> Comment -> Html Msg
parentComment model comment =
    div [ classes [ "center", "flex", "flex-column", "content-center", "bg-green", "br3", "ph4", "pv3", "ma4", "bg-light-green" ] ]
        [ div [ classes [ "green", "mb3" ] ]
            [ h1 [ classes [ "fw5", "f3", "di" ] ] [ text comment.name ]
            , span [] [ text " - " ]
            , h2 [ class "di fw3 f3" ] [ text <| (unionTypeToString comment.lawCentre) ++ " Law Centre" ]
            ]
        , p [ classes [ "fw3", "lh-copy", "mb3" ] ] [ text comment.commentBody ]
        ]


showParentComment : Model -> Comment -> Html Msg
showParentComment model comment =
    case comment.parentId of
        Just commentId ->
            parentComment model (getCommentByCommentId model commentId)

        Nothing ->
            emptyDiv
