module View exposing (..)

import Html exposing (..)


-- My Elm Files

import Types exposing (..)
import Routes.Home exposing (..)
import Routes.WorkerView exposing (..)
import Routes.RepView exposing (..)
import Routes.Navbar exposing (..)


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
            [ navbar model
            , page
            ]
