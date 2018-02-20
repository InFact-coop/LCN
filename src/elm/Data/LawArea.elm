module Data.LawArea exposing (..)

import Json.Decode exposing (Decoder)
import Types exposing (..)


stringToLawArea : String -> LawArea
stringToLawArea string =
    case string of
        "Family" ->
            Family

        "Immigration" ->
            Immigration

        _ ->
            Family


decoderLawArea : String -> Decoder LawArea
decoderLawArea val =
    case val of
        "Family" ->
            Json.Decode.succeed Family

        "Immigration" ->
            Json.Decode.succeed Immigration

        _ ->
            Json.Decode.succeed NoArea
