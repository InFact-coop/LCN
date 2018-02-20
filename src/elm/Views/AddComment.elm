module Views.AddComment exposing (..)

import Components.StyleHelpers exposing (bodyFont, buttonStyle, classes, headlineFont, submitButtonStyle, topicButtonFont)
import Data.CommentType exposing (commentTypeColor, commentTypes)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Views.ListComments exposing (topicButton)


addCommentView : Model -> Html Msg
addCommentView model =
    div [ class "flex flex-column items-center w-80 center" ]
        [ div []
            [ div [ class "mv4" ] summary
            , div [ class "mv4" ] chooseTopic
            , div [ class "flex flex-column" ] <| inputComment model
            , submitButton model
            ]
        ]


summary : List (Html Msg)
summary =
    [ h1 [ classes [ headlineFont ] ] [ text "Summary" ]
    , p [ classes [ bodyFont, "mt2" ] ] [ text "An intro to this section could go here. Explaining that it's optional and why the information is useful" ]
    ]


chooseTopic : List (Html Msg)
chooseTopic =
    [ h1 [ classes [ headlineFont, "mb3" ] ] [ text "Choose a topic" ]
    , div [ class "flex justify-between mt2" ]
        (List.map
            topicButton
            commentTypes
        )
    ]


inputComment : Model -> List (Html Msg)
inputComment model =
    [ h1
        [ classes [ headlineFont, "" ] ]
      <|
        commentHeading model
    , textarea
        [ classes [ "bn mv3 pa3", bodyFont ]
        , attribute "rows" "4"
        , attribute "placeholder" "Write your comment here"
        , onInput UpdateCommentBody
        , value model.commentBody
        ]
        []
    ]


commentHeading : Model -> List (Html Msg)
commentHeading model =
    case model.commentType of
        Success ->
            [ text "Tell us about the "
            , span [ classes [ (commentTypeColor Success), "b" ] ] [ text "success" ]
            , text " you've had"
            ]

        Annoyance ->
            [ text "Tell us about the "
            , span [ classes [ (commentTypeColor Annoyance), "b" ] ] [ text "annoyance " ]
            , text "you've had"
            ]

        Trend ->
            [ text "Tell us about a "
            , span [ classes [ (commentTypeColor Trend), "b" ] ] [ text "trend " ]
            , text "you've noticed"
            ]

        AskUs ->
            [ text "Ask us a "
            , span [ classes [ (commentTypeColor AskUs), "b" ] ] [ text "question" ]
            ]

        NoType ->
            []


submitButton : Model -> Html Msg
submitButton model =
    button
        [ classes
            [ topicButtonFont
            , submitButtonStyle
            , ("bg-" ++ (commentTypeColor model.commentType))
            ]
        , onClick PostComment
        ]
        [ text "Submit" ]
