module Data.LawArea exposing (decoderLawArea, stringToLawArea)

import Json.Decode exposing (Decoder)
import Types exposing (..)


stringToLawArea : String -> LawArea
stringToLawArea string =
    case string of
        "No Area" ->
            NoArea

        "Welfare And Benefits" ->
            WelfareAndBenefits

        "Employment" ->
            Employment

        "Debt" ->
            Debt

        "Housing" ->
            Housing

        "Immigration And Asylum" ->
            ImmigrationAndAsylum

        "Family" ->
            Family

        "Community Care" ->
            CommunityCare

        "Public Law" ->
            PublicLaw

        _ ->
            NoArea


decoderLawArea : String -> Decoder LawArea
decoderLawArea val =
    case val of
        "No Area" ->
            Json.Decode.succeed NoArea

        "Welfare And Benefits" ->
            Json.Decode.succeed WelfareAndBenefits

        "Employment" ->
            Json.Decode.succeed Employment

        "Debt" ->
            Json.Decode.succeed Debt

        "Housing" ->
            Json.Decode.succeed Housing

        "Immigration And Asylum" ->
            Json.Decode.succeed ImmigrationAndAsylum

        "Family" ->
            Json.Decode.succeed Family

        "Community Care" ->
            Json.Decode.succeed CommunityCare

        "Public Law" ->
            Json.Decode.succeed PublicLaw

        _ ->
            Json.Decode.succeed NoArea
