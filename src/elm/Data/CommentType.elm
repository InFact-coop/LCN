module Data.CommentType exposing (..)

import Types exposing (..)


commentTypes : List CommentType
commentTypes =
    [ Trend, Success, Annoyance, AskUs ]


commentTypeToString : CommentType -> String
commentTypeToString commentType =
    case commentType of
        Trend ->
            "Trend"

        Success ->
            "Success"

        Annoyance ->
            "Annoyance"

        AskUs ->
            "Ask Us"


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
