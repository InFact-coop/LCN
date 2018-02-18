module Data.Comment exposing (..)

import Types exposing (..)


defaultComment : Comment
defaultComment =
    Comment "" Nothing "" NoCentre "" 0 NoType NoArea 0


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
