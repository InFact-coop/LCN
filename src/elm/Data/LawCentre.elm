module Data.LawCentre exposing (..)

import Json.Decode exposing (..)
import Types exposing (..)


stringToLawCentre : String -> LawCentre
stringToLawCentre val =
    case val of
        "Camden" ->
            Camden

        "No Centre" ->
            NoCentre

        _ ->
            NoCentre


decoderLC : String -> Decoder LawCentre
decoderLC val =
    case val of
        "Camden" ->
            Json.Decode.succeed Camden

        "No Centre" ->
            Json.Decode.succeed NoCentre

        _ ->
            Json.Decode.succeed NoCentre
