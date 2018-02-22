module Data.CommentType exposing (..)

import Types exposing (..)


commentTypes : List CommentType
commentTypes =
    [ Success, Annoyance, Trend, AskUs ]


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

        NoType ->
            "white"


commentTypeColorLight : CommentType -> String
commentTypeColorLight commentType =
    case commentType of
        Trend ->
            "pink"

        Success ->
            "green"

        Annoyance ->
            "red"

        AskUs ->
            "blue"

        NoType ->
            "white"


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
