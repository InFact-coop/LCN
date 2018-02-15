module Data.LawCentre exposing (..)

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
