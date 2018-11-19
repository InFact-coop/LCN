module Components.StatsModal exposing (statsModal)

import Components.StyleHelpers exposing (classes, displayElement, emptySpan)
import Helpers exposing (ifThenElse, prettifyNumber, unionTypeToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


caseWorkerStat : StatsData -> LawArea -> Html Msg
caseWorkerStat statsData lawArea =
    div []
        [ h2 [ classes [ "f2", "fw3", "mt3", "mb4" ] ]
            [ text "seen "
            , span [ class "pink b" ] [ text <| (prettifyNumber <| Maybe.withDefault 0 <| statsData.clientMattersByArea) ++ " " ++ unionTypeToString lawArea ++ " cases " ]
            , text "(and "
            , span [ class "pink b" ] [ text <| (prettifyNumber <| Maybe.withDefault 0 <| statsData.clientMatters) ++ " cases " ]
            , text "altogether)"
            ]
        ]


managementStat : StatsData -> Html Msg
managementStat statsData =
    let
        lawyerVolunteers =
            statsData.lawyerVolunteers |> Maybe.withDefault 0

        studentVolunteers =
            statsData.studentVolunteers |> Maybe.withDefault 0
    in
    div []
        [ h2 [ classes [ "f2", "fw3", "mt3", "mb4" ] ]
            [ text "involved "
            , span [ class "pink b" ] [ text <| (prettifyNumber <| lawyerVolunteers + studentVolunteers) ++ " " ++ " volunteers" ]
            ]
        , h2 [ classes [ "f2", "fw3", "mt3", "mb4" ] ]
            [ text "advertised "
            , span [ class "pink b" ] [ text <| (prettifyNumber <| Maybe.withDefault 0 <| statsData.vacancies) ++ " job opportunities" ]
            ]
        , h2 [ classes [ "f2", "fw3", "mt3", "mb4" ] ]
            [ text "been covered in "
            , span [ class "pink b" ] [ text <| (prettifyNumber <| Maybe.withDefault 0 <| statsData.mediaCoverage) ++ " stories " ]
            , text "in the media"
            ]
        ]


triageStat : StatsData -> Html Msg
triageStat statsData =
    div []
        [ h2 [ classes [ "f2", "fw3", "mt3", "mb4" ] ]
            [ text "responded to "
            , span [ class "pink b" ] [ text <| (prettifyNumber <| Maybe.withDefault 0 <| statsData.enquiries) ++ " enquiries " ]
            ]
        ]


statsResponseView : Model -> Html Msg
statsResponseView model =
    div []
        [ h2 [ classes [ "f2", "fw5", "mt3" ] ]
            [ text "With your help," ]
        , h2 [ classes [ "f2", "fw5", "mb4" ] ] [ text "this week Law Centres have..." ]
        , ifThenElse (List.member CaseWorker model.roles) (caseWorkerStat model.statsResponse model.lawArea) emptySpan
        , ifThenElse (List.member Triage model.roles) (triageStat model.statsResponse) emptySpan
        , ifThenElse (List.member Management model.roles) (managementStat model.statsResponse) emptySpan
        ]


statsModal : Model -> Html Msg
statsModal model =
    let
        name =
            if model.name /= "" then
                ", " ++ model.name

            else
                ""
    in
    section
        [ classes
            [ "modal fixed f3 ph5-ns ph4 pb4 pt5 bg-white br2 w-70-ns w-90 z-3 center tc"
            , displayElement model.displayStatsModal
            ]
        ]
        [ img
            [ src "assets/tick.svg"
            , classes
                [ "icon-above"
                , "h4"
                , "w4"
                , "absolute"
                ]
            , alt "Success"
            ]
            []
        , section [ classes [ "success" ] ]
            [ h1 [ classes [ "f2", "mb4", "mt3", "b" ] ] [ text <| "Thank you" ++ name ++ "!" ]
            , statsResponseView model
            ]
        ]
