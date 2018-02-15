module Views.ListComments exposing (..)

import Components.StyleHelpers exposing (bodyFont, buttonStyle, classes, headlineFont)
import Data.CommentType exposing (commentTypeColor, commentTypeToString, commentTypes)
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
        [ text <| commentTypeToString commentType ]
