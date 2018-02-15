module Helpers exposing (..)

import Regex exposing (..)
import Types exposing (..)


ifThenElse : Bool -> a -> a -> a
ifThenElse conditional trueCase falseCase =
    if conditional then
        trueCase
    else
        falseCase


unionTypeToLabel : a -> String
unionTypeToLabel a =
    Regex.replace All
        (Regex.regex "[A-Z]")
        (\{ match } -> " " ++ match)
        (toString a)
        |> String.trim
