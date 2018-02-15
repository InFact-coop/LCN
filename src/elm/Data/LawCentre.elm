module Data.LawCentre exposing (..)

import Types exposing (..)


stringToLawCentre : String -> LawCentre
stringToLawCentre val =
    case val of
        "Camden" ->
            Camden

        "None" ->
            NoCentre

        _ ->
            NoCentre
