module Components.LawCentre exposing (..)

import Helpers exposing (unionTypeToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


lawCentreOption : LawCentre -> Html Msg
lawCentreOption lc =
    option [ class "f3", value <| unionTypeToString lc ] [ text <| unionTypeToString lc ]


lawCentreList : List LawCentre
lawCentreList =
    [ AvonAndBristol, Birmingham, Brent, Bury, CambridgeHouse, Camden, Bradford, Coventry, Croydon, Cumbria, Derbyshire, Ealing, Gloucester, Manchester, Hackney, HammersmithAndFulham, Haringey, Harrow, Hillingdon, IsleOfWight, Islington, KingstonAndRichmond, Kirklees, Lambeth, NorthernIreland, WesternAreaNorthernIreland, Luton, Merseyside, MertonAndSutton, Newcastle, NorthKensington, Nottingham, Paddington, Plumstead, Rochdale, Sheffield, Southwark, Springfield, Surrey, TowerHamlets, Vauxhall, Wandsworth, Wiltshire ]
