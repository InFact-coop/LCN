module Data.LawCentre exposing (decoderLC, stringToLawCentre)

import Json.Decode exposing (..)
import Types exposing (..)


stringToLawCentre : String -> LawCentre
stringToLawCentre val =
    case val of
        "Avon And Bristol" ->
            AvonAndBristol

        "Birmingham" ->
            Birmingham

        "Brent" ->
            Brent

        "Bury" ->
            Bury

        "Cambridge House" ->
            CambridgeHouse

        "Camden" ->
            Camden

        "Bradford" ->
            Bradford

        "Coventry" ->
            Coventry

        "Croydon" ->
            Croydon

        "Cumbria" ->
            Cumbria

        "Derbyshire" ->
            Derbyshire

        "Ealing" ->
            Ealing

        "Gloucester" ->
            Gloucester

        "Manchester" ->
            Manchester

        "Hackney" ->
            Hackney

        "Hammersmith And Fulham" ->
            HammersmithAndFulham

        "Haringey" ->
            Haringey

        "Harrow" ->
            Harrow

        "Hillingdon" ->
            Hillingdon

        "Isle Of Wight" ->
            IsleOfWight

        "Islington" ->
            Islington

        "Kingston And Richmond" ->
            KingstonAndRichmond

        "Kirklees" ->
            Kirklees

        "Lambeth" ->
            Lambeth

        "Northern Ireland" ->
            NorthernIreland

        "Western Area Northern Ireland" ->
            WesternAreaNorthernIreland

        "Luton" ->
            Luton

        "Merseyside" ->
            Merseyside

        "Merton And Sutton" ->
            MertonAndSutton

        "Newcastle" ->
            Newcastle

        "North Kensington" ->
            NorthKensington

        "Nottingham" ->
            Nottingham

        "Paddington" ->
            Paddington

        "Plumstead" ->
            Plumstead

        "Rochdale" ->
            Rochdale

        "Sheffield" ->
            Sheffield

        "Southwark" ->
            Southwark

        "Springfield" ->
            Springfield

        "Surrey" ->
            Surrey

        "Tower Hamlets" ->
            TowerHamlets

        "Vauxhall" ->
            Vauxhall

        "Wandsworth" ->
            Wandsworth

        "Wiltshire" ->
            Wiltshire

        _ ->
            NoCentre


decoderLC : String -> Decoder LawCentre
decoderLC val =
    case val of
        "Avon And Bristol" ->
            Json.Decode.succeed AvonAndBristol

        "Birmingham" ->
            Json.Decode.succeed Birmingham

        "Brent" ->
            Json.Decode.succeed Brent

        "Bury" ->
            Json.Decode.succeed Bury

        "Cambridge House" ->
            Json.Decode.succeed CambridgeHouse

        "Camden" ->
            Json.Decode.succeed Camden

        "Bradford" ->
            Json.Decode.succeed Bradford

        "Coventry" ->
            Json.Decode.succeed Coventry

        "Croydon" ->
            Json.Decode.succeed Croydon

        "Cumbria" ->
            Json.Decode.succeed Cumbria

        "Derbyshire" ->
            Json.Decode.succeed Derbyshire

        "Ealing" ->
            Json.Decode.succeed Ealing

        "Gloucester" ->
            Json.Decode.succeed Gloucester

        "Manchester" ->
            Json.Decode.succeed Manchester

        "Hackney" ->
            Json.Decode.succeed Hackney

        "Hammersmith And Fulham" ->
            Json.Decode.succeed HammersmithAndFulham

        "Haringey" ->
            Json.Decode.succeed Haringey

        "Harrow" ->
            Json.Decode.succeed Harrow

        "Hillingdon" ->
            Json.Decode.succeed Hillingdon

        "Isle Of Wight" ->
            Json.Decode.succeed IsleOfWight

        "Islington" ->
            Json.Decode.succeed Islington

        "Kingston And Richmond" ->
            Json.Decode.succeed KingstonAndRichmond

        "Kirklees" ->
            Json.Decode.succeed Kirklees

        "Lambeth" ->
            Json.Decode.succeed Lambeth

        "Northern Ireland" ->
            Json.Decode.succeed NorthernIreland

        "Western Area Northern Ireland" ->
            Json.Decode.succeed WesternAreaNorthernIreland

        "Luton" ->
            Json.Decode.succeed Luton

        "Merseyside" ->
            Json.Decode.succeed Merseyside

        "Merton And Sutton" ->
            Json.Decode.succeed MertonAndSutton

        "Newcastle" ->
            Json.Decode.succeed Newcastle

        "North Kensington" ->
            Json.Decode.succeed NorthKensington

        "Nottingham" ->
            Json.Decode.succeed Nottingham

        "Paddington" ->
            Json.Decode.succeed Paddington

        "Plumstead" ->
            Json.Decode.succeed Plumstead

        "Rochdale" ->
            Json.Decode.succeed Rochdale

        "Sheffield" ->
            Json.Decode.succeed Sheffield

        "Southwark" ->
            Json.Decode.succeed Southwark

        "Springfield" ->
            Json.Decode.succeed Springfield

        "Surrey" ->
            Json.Decode.succeed Surrey

        "Tower Hamlets" ->
            Json.Decode.succeed TowerHamlets

        "Vauxhall" ->
            Json.Decode.succeed Vauxhall

        "Wandsworth" ->
            Json.Decode.succeed Wandsworth

        "Wiltshire" ->
            Json.Decode.succeed Wiltshire

        _ ->
            Json.Decode.succeed NoCentre
