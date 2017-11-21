module View exposing (..)

import Html exposing (..)


-- My Elm Files

import Types exposing (..)
import Routes.Home exposing (..)
import Routes.WorkerView exposing (..)
import Routes.PageTwo exposing (..)
import Routes.Navbar exposing (..)


view : Model -> Html Msg
view model =
    let
        page =
            case model.route of
                HomeRoute ->
                    home model

                WorkerView ->
                    workerView model

                PageTwoRoute ->
                    pageTwo model
    in
        div []
            [ navbar model
            , page
            ]
