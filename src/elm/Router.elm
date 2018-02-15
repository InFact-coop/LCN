module Router exposing (..)

import Components.Nav exposing (navBar)
import Components.StatsModal exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)
import Navigation exposing (..)
import Views.Home exposing (..)
import Views.AddStats exposing (..)
import Views.Snapshot exposing (..)
import Views.AddComment exposing (..)
import Views.ListComments exposing (..)


view : Model -> Html Msg
view model =
    let
        view =
            getCurrentView model
    in
        div [ class "w-100 fixed overflow-y-scroll top-0 bottom-0 bg-light-blue m0-auto cover", id "container" ]
            [ modalBackground model
            , statsModal model
            , navBar model
            , view
            ]


getCurrentView : Model -> Html Msg
getCurrentView model =
    case model.view of
        Home ->
            homeView model

        AddStats ->
            addStatsView model

        Snapshot ->
            snapshotView model

        AddComment ->
            addCommentView model

        ListComments ->
            listCommentsView model


getView : String -> View
getView hash =
    case hash of
        "#home" ->
            Home

        "#numbers" ->
            AddStats

        "#numbers-snapshot" ->
            Snapshot

        "#add-comment" ->
            AddComment

        "#list-comments" ->
            ListComments

        "#logout" ->
            Home

        _ ->
            Home


viewFromUrl : Navigation.Location -> Model -> Model
viewFromUrl location model =
    let
        view =
            getView location.hash
    in
        { model | view = view }
