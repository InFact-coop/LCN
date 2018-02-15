module Data.LawArea exposing (..)

import Json.Decode exposing (Decoder)
import Types exposing (..)


stringToLawArea : String -> LawArea
stringToLawArea string =
    case string of
        "Criminal" ->
            Criminal

        "Immigration" ->
            Immigration

        _ ->
            Criminal


decoderLawArea : String -> Decoder LawArea
decoderLawArea val =
    case val of
        "Criminal" ->
            Json.Decode.succeed Criminal

        "Immigration" ->
            Json.Decode.succeed Immigration

        _ ->
            Json.Decode.succeed NoArea
