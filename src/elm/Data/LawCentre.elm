module Data.LawCentre exposing (..)

import Types exposing (..)


lawCentreToString : LawCentre -> String
lawCentreToString lawCentre =
    case lawCentre of
        Camden ->
            "Camden"

        NoCentre ->
            "No Centre"
