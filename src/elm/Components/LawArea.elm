module Components.LawArea exposing (lawAreaList, lawAreaOption)

import Components.StyleHelpers exposing (classes)
import Helpers exposing (ifThenElse, unionTypeToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


lawAreaOption : LawArea -> Html Msg
lawAreaOption la =
    option
        ([ classes
            [ "f3" ]
         , value <| unionTypeToString la
         ]
            ++ ifThenElse
                (la
                    == NoArea
                )
                [ disabled True, selected True ]
                [ selected False, disabled False ]
        )
        [ text <| ifThenElse (la == NoArea) "Please select" (unionTypeToString la) ]


lawAreaList : List LawArea
lawAreaList =
    [ NoArea
    , WelfareAndBenefits
    , Employment
    , Debt
    , Housing
    , ImmigrationAndAsylum
    , Family
    , CommunityCare
    , PublicLaw
    ]
