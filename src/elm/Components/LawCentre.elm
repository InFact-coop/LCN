module Components.LawCentre exposing (..)

import Components.StyleHelpers exposing (classes)
import Helpers exposing (unionTypeToString, ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


lawCentreOption : LawCentre -> Html Msg
lawCentreOption lc =
    option
        ([ classes [ "f3" ], value <| unionTypeToString lc ]
            ++ ifThenElse
                (lc
                    == NoCentre
                )
                [ disabled True, selected True ]
                [ selected False, disabled False ]
        )
        [ text <| ifThenElse (lc == NoCentre) "Please select" (unionTypeToString lc) ]


lawCentreList : List LawCentre
lawCentreList =
    [ NoCentre, AvonAndBristol, Birmingham, Brent, Bury, CambridgeHouse, Camden, Bradford, Coventry, Croydon, Cumbria, Derbyshire, Ealing, Gloucester, Manchester, Hackney, HammersmithAndFulham, Haringey, Harrow, Hillingdon, IsleOfWight, Islington, KingstonAndRichmond, Kirklees, Lambeth, NorthernIreland, WesternAreaNorthernIreland, Luton, Merseyside, MertonAndSutton, Newcastle, NorthKensington, Nottingham, Paddington, Plumstead, Rochdale, Sheffield, Southwark, Springfield, Surrey, TowerHamlets, Vauxhall, Wandsworth, Wiltshire ]
