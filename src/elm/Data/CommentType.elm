module Data.CommentType exposing (..)

import Types exposing (..)


commentTypes : List CommentType
commentTypes =
    [ Trend, Success, Annoyance, AskUs ]


commentTypeColor : CommentType -> String
commentTypeColor commentType =
    case commentType of
        Trend ->
            "pink"

        Success ->
            "green"

        Annoyance ->
            "orange"

        AskUs ->
            "blue"
