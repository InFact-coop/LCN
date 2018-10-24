module Data.Role exposing (stringToRole)

import Types exposing (..)


stringToRole : String -> Role
stringToRole string =
    case string of
        "Case Worker" ->
            CaseWorker

        "Management" ->
            Management

        "Triage" ->
            Triage

        "No Role" ->
            NoRole

        _ ->
            NoRole
