module Data.Role exposing (stringToRole, updateRoles)

import Helpers exposing (..)
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


updateRoles : Model -> Role -> List Role
updateRoles model newRole =
    if List.member NoRole model.roles then
        [ newRole ]

    else if List.member newRole model.roles then
        List.filter (\existingRole -> existingRole /= newRole) model.roles
            |> (\roles -> ifThenElse (List.isEmpty roles) [ NoRole ] roles)

    else
        model.roles ++ [ newRole ]
