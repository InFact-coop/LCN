module Components.ChooseTopic exposing (chooseTopic, topicButton)

import Components.StyleHelpers exposing (..)
import Data.CommentType exposing (commentTypeColor, commentTypes)
import Helpers exposing (ifThenElse, unionTypeToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


chooseTopic : Model -> List (Html Msg)
chooseTopic model =
    [ h1 [ classes [ headlineFont, "mb3" ] ] [ text "Choose a topic" ]
    , div [ class "flex flex-row-ns flex-column justify-between-ns mt2" ]
        (List.map
            (topicButton model)
            commentTypes
        )
    ]


topicButton : Model -> CommentType -> Html Msg
topicButton model commentType =
    button
        [ classes
            [ "w5-ns white w-100 mb2"
            , topicButtonFont
            , buttonStyle
            , "bg-" ++ commentTypeColor commentType
            , ifThenElse (model.commentType == commentType) "grow" "o-30 shrink"
            ]
        , onClick <| UpdateCommentType commentType
        ]
        [ text <| unionTypeToString commentType ]
