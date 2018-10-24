module Components.Button exposing
    ( bigColouredButton
    , colouredButton
    , colouredButtonText
    , modalButton
    )

import Components.StyleHelpers
    exposing
        ( buttonStyle
        , classes
        , roleButtonFont
        , submitButtonStyle
        , topicButtonFont
        )
import Helpers exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


colouredButton : String -> Role -> Html Msg
colouredButton colour role =
    button
        [ classes
            [ "mr3 white  w-100 w5-5-l mb2 mb0-l"
            , "bg-" ++ colour
            , roleButtonFont
            , buttonStyle
            ]
        , onClick <| UpdateRoles role
        ]
        [ text <| colouredButtonText role ]


colouredButtonText : Role -> String
colouredButtonText role =
    case role of
        CaseWorker ->
            "Lawyer/Case Worker"

        Triage ->
            "Triage/Reception"

        _ ->
            unionTypeToString role


bigColouredButton : Bool -> String -> String -> Msg -> Html Msg
bigColouredButton validationPassed colour label clickMsg =
    button
        [ classes
            [ "mr4 white"
            , ifThenElse validationPassed
                ("bg-" ++ colour)
                "bg-gray disableButton o-30"
            , submitButtonStyle
            , topicButtonFont
            ]
        , onClick <| ifThenElse validationPassed clickMsg NoOp
        ]
        [ text label ]


modalButton : String -> String -> Html Msg
modalButton label linkTo =
    a
        [ class "dib link black pv3 w-33-l w-60-m w-100 mb3 mh2-l br4 fw3 f4 ba b--light-gray bw1 pointer grow"
        , href linkTo
        , onClick ToggleStatsModal
        ]
        [ text label ]
