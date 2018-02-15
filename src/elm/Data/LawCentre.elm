module Data.LawCentre exposing (..)

import Types exposing (..)
import Json.Decode exposing (Decoder)


lawCentreToString : LawCentre -> String
lawCentreToString lawCentre =
    case lawCentre of
        Camden ->
            "Camden"

        NoCentre ->
            "No Centre"


decoderLC : String -> Decoder LawCentre
decoderLC val =
    case val of
        "Camden" ->
            Json.Decode.succeed Camden

        "None" ->
            Json.Decode.succeed NoCentre

        _ ->
            Json.Decode.succeed NoCentre
