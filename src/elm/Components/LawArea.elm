module Components.LawArea exposing (..)

import Helpers exposing (unionTypeToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


lawAreaOption : LawArea -> Html Msg
lawAreaOption la =
    option [ class "f3", value <| unionTypeToString la ] [ text <| unionTypeToString la ]


lawAreaList : List LawArea
lawAreaList =
    [ WelfareAndBenefits
    , Employment
    , Debt
    , Housing
    , ImmigrationAndAsylum
    , Family
    , CommunityCare
    , PublicLaw
    ]
