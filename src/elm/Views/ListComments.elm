module Views.ListComments exposing (..)

import Components.StyleHelpers exposing (bodyFont, buttonStyle, classes, displayElement, emptyDiv, headlineFont)
import Data.Comment exposing (commentTypeColor, commentTypes, defaultComment)
import Helpers exposing (unionTypeToString)
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
                    List.sortBy .createdAt <|
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
    div [ classes [ "center", "flex", "flex-column", "content-center", "bg-white", "br3", "ph4", "pv3", "ma4" ] ]
        [ showParentComment model comment
        , div [ classes [ "green", "mb3" ] ] [ h1 [ classes [ "fw5", "f3", "di" ] ] [ text comment.name ], span [] [ text " - " ], h2 [ classes [ "di" ] ] [ text <| unionTypeToString comment.lawCentre ] ]
        , p [ classes [ "fw3", "lh-copy", "mb3" ] ] [ text comment.commentBody ]
        , div [ classes [ "flex", "content-center", "h2" ] ] [ button [ classes [ "pointer", "bn", "bg-green", "ph4", "white", "f4", "br1", "mr3", displayElement <| hasParentId comment ] ] [ text "reply" ], img [ src "./assets/like.svg", classes [ "w2", "v-mid" ] ] [] ]
        ]


parentComment : Model -> Comment -> Html Msg
parentComment model comment =
    div [ classes [ "center", "flex", "flex-column", "content-center", "bg-green", "br3", "ph4", "pv3", "ma4" ] ]
        [ div [ classes [ "green", "mb3" ] ] [ h1 [ classes [ "fw5", "f3", "di" ] ] [ text comment.name ], span [] [ text " - " ], h2 [ classes [ "di" ] ] [ text <| unionTypeToString comment.lawCentre ] ]
        , p [ classes [ "fw3", "lh-copy", "mb3" ] ] [ text comment.commentBody ]
        ]


hasParentId : Comment -> Bool
hasParentId comment =
    case comment.parentId of
        Just _ ->
            False

        Nothing ->
            True


showParentComment : Model -> Comment -> Html Msg
showParentComment model comment =
    case comment.parentId of
        Just commentId ->
            parentComment model (getCommentByCommentId model commentId)

        Nothing ->
            emptyDiv


getCommentByCommentId : Model -> CommentId -> Comment
getCommentByCommentId model commentId =
    List.filter (\comment -> comment.id == commentId) model.comments
        |> List.head
        |> Maybe.withDefault defaultComment
