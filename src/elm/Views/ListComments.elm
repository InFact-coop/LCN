module Views.ListComments exposing (..)

import Components.StyleHelpers exposing (bodyFont, buttonStyle, classes, headlineFont)
import Data.CommentType exposing (commentTypeColor, commentTypes)
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
                (List.map singleComment <|
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


singleComment : Comment -> Html Msg
singleComment comment =
    div [ class "flex flex-row justify-between" ]
        [ p [] [ text ("Name: " ++ comment.name) ]
        , p [] [ text ("Comment: " ++ comment.commentBody) ]
        , p [] [ text ("Likes: " ++ toString comment.likes) ]
        , p [] [ text ("Topic: " ++ unionTypeToString comment.commentType) ]
        ]
