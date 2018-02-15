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
