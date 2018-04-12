module Helpers exposing (..)

import Dom.Scroll exposing (..)
import Regex exposing (..)
import Task
import Types exposing (..)
import Json.Decode as Json
import Html exposing (..)
import Html.Events exposing (..)


ifThenElse : Bool -> a -> a -> a
ifThenElse conditional trueCase falseCase =
    if conditional then
        trueCase
    else
        falseCase


unionTypeToString : a -> String
unionTypeToString a =
    Regex.replace All
        (Regex.regex "[A-Z]")
        (\{ match } -> " " ++ match)
        (toString a)
        |> String.trim


scrollToTop : Cmd Msg
scrollToTop =
    Task.attempt (always NoOp) (toTop "container")


prettifyNumber : Int -> String
prettifyNumber number =
    let
        numberString =
            toString number
    in
        if String.length numberString > 3 then
            String.dropRight 3 numberString ++ "," ++ String.right 3 numberString
        else
            numberString


isNewEntry : String -> List String -> Bool
isNewEntry string stringList =
    List.member string stringList
        |> not


removeSpaces : String -> String
removeSpaces string =
    string
        |> String.toLower
        |> String.words
        |> String.join ""


onInputValue : (String -> msg) -> Attribute msg
onInputValue tagger =
    on "input" (Json.map tagger targetValue)


onBlurValue : (String -> msg) -> Attribute msg
onBlurValue tagger =
    on "blur" (Json.map tagger targetValue)
