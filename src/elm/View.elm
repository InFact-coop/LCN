module View exposing (..)

-- My Elm Files

import Html exposing (..)
import Routes.Home exposing (..)
import Routes.RepView exposing (..)
import Routes.WorkerView exposing (..)
import Types exposing (..)


view : Model -> Html Msg
view model =
    let
        page =
            case model.route of
                HomeRoute ->
                    home model

                WorkerViewRoute ->
                    workerView model

                RepViewRoute ->
                    repView model
    in
    div []
        [ page
        ]
