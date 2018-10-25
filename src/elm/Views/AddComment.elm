module Views.AddComment exposing
    ( addCommentView
    , inputComment
    , submitButton
    , summary
    , summaryText
    , topicExplanation
    , topicHeading
    )

import Components.ChooseTopic exposing (chooseTopic)
import Components.StyleHelpers exposing (bodyFont, buttonStyle, classes, headlineFont, submitButtonStyle, topicButtonFont)
import Data.CommentType exposing (commentTypeColor, commentTypes)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


addCommentView : Model -> Html Msg
addCommentView model =
    div [ class "flex flex-column items-center w-80-ns w-90 center" ]
        [ div []
            [ div [ class "mv4" ] summary
            , div [ class "mv4" ] <| chooseTopic model
            , div [ class "flex flex-column" ] <| inputComment model
            , submitButton model
            ]
        ]


summary : List (Html Msg)
summary =
    [ h1 [ classes [ headlineFont ] ] [ text "Tell us more..." ]
    , p [ classes [ bodyFont, "mt2" ] ] [ text summaryText ]
    ]


summaryText : String
summaryText =
    """
    Tell us about the kind of issues that you have seen this week; you can be as brief as you like,
    and submit as many or as few insights as you'd like. Here you can also ask or make a request of
    LCN. Answers all appear in the next section - where you can also comment on other people's thoughts.
    """


inputComment : Model -> List (Html Msg)
inputComment model =
    [ h1 [ classes [ headlineFont, "" ] ] <| topicHeading model
    , p [ classes [ bodyFont, "mt2" ] ] <| topicExplanation model
    , textarea
        [ classes [ "bn mv3 pa3", bodyFont ]
        , attribute "rows" "4"
        , attribute "placeholder" "Write your comment here"
        , onInput UpdateCommentBody
        , value model.commentBody
        ]
        []
    ]


topicExplanation : Model -> List (Html Msg)
topicExplanation model =
    case model.commentType of
        Success ->
            [ text "Tell us about a case that you are proud of, or a client outcome that has made you particularly happy. We don't celebrate these good and inspiring moments enough. Let's change that!" ]

        Annoyance ->
            [ text "What's got your goat this week? What policy or procedure have you come up against which you think is particularly crap? And what can be done to make it better?" ]

        Trend ->
            [ text "These can be declines or rises in certain types of problems, problem clusters, client groups. What is your hunch as to why this is happening?" ]

        AskUs ->
            [ text "Have you got a question or a request for LCN? Let us know here and we will get back to you!" ]

        NoType ->
            []


topicHeading : Model -> List (Html Msg)
topicHeading model =
    case model.commentType of
        Success ->
            [ text "Tell us about a "
            , span [ classes [ commentTypeColor Success, "b" ] ] [ text "success" ]
            , text " you've had"
            ]

        Annoyance ->
            [ text "Tell us about an "
            , span [ classes [ commentTypeColor Annoyance, "b" ] ] [ text "annoyance " ]
            , text "you've had"
            ]

        Trend ->
            [ text "What "
            , span [ classes [ commentTypeColor Trend, "b" ] ] [ text "trend(s) " ]
            , text "are you seeing at the moment?"
            ]

        AskUs ->
            [ text "Ask us a "
            , span [ classes [ commentTypeColor AskUs, "b" ] ] [ text "question" ]
            , text "!"
            ]

        NoType ->
            []


submitButton : Model -> Html Msg
submitButton model =
    let
        validate =
            model.commentBody /= ""
    in
    button
        [ classes
            [ topicButtonFont
            , submitButtonStyle
            , ifThenElse validate
                ("bg-" ++ commentTypeColor model.commentType)
                "bg-gray disableButton o-30"
            ]
        , onClick <| ifThenElse validate PostComment NoOp
        ]
        [ text "Submit" ]
