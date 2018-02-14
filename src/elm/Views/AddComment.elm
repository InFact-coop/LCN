module Views.AddComment exposing (..)

import Components.StyleHelpers exposing (bodyFont, buttonStyle, classes, headlineFont)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


addCommentView : Model -> Html Msg
addCommentView model =
    div [ class "flex flex-column items-center" ]
        [ div []
            [ div [ class "mv3" ] summary
            , div [ class "mv3" ] chooseTopic
            , div [ class "flex flex-column" ] inputComment
            ]
        ]


summary : List (Html Msg)
summary =
    [ h1 [ classes [ headlineFont, "" ] ] [ text "Summary" ]
    , p [ classes [ bodyFont ] ] [ text "An intro to this section could go here. Explaining that it's optional and why the information is useful" ]
    ]


chooseTopic : List (Html Msg)
chooseTopic =
    [ h1 [ classes [ headlineFont, "" ] ] [ text "Choose a topic" ]
    , div [ class "flex justify-between mt2" ]
        (List.map
            topicButton
            topics
        )
    ]


inputComment : List (Html Msg)
inputComment =
    [ h1 [ classes [ headlineFont, "" ] ] [ text "Tell us about the success you've had" ]
    , textarea
        [ classes [ "bn mv3 pa3", bodyFont ]
        , attribute "rows" "4"
        , attribute "placeholder" "Write your comment here"
        ]
        []
    , button [ classes [ "ph3 pv2 w5 white bg-washed-green", bodyFont, buttonStyle ] ] [ text "Submit" ]
    ]


topicButton : CommentType -> Html Msg
topicButton commentType =
    button
        [ classes
            [ "ph3 pv2 w5 white"
            , bodyFont
            , buttonStyle
            , buttonColor (commentType)
            ]
        ]
        [ text <| commentTypeToString commentType ]


topics : List CommentType
topics =
    [ Trend, Success, Annoyance, AboutUs ]


commentTypeToString : CommentType -> String
commentTypeToString commentType =
    case commentType of
        Trend ->
            "Trend"

        Success ->
            "Success"

        Annoyance ->
            "Annoyance"

        AboutUs ->
            "About Us"


buttonColor : CommentType -> String
buttonColor commentType =
    case commentType of
        Trend ->
            "bg-dark-pink"

        Success ->
            "bg-washed-green"

        Annoyance ->
            "bg-orange"

        AboutUs ->
            "bg-washed-blue"
