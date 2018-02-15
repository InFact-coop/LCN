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


stringToCommmentType : String -> CommentType
stringToCommmentType commentTypeString =
    case commentTypeString of
        "Trend" ->
            Trend

        "Success" ->
            Success

        "Annoyance" ->
            Annoyance

        "Ask Us" ->
            AskUs

        _ ->
            Success
