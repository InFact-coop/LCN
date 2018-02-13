module Router exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)
import Navigation exposing (..)
import Views.Home exposing (..)
import Views.QuantForm exposing (..)
import Views.Snapshot exposing (..)
import Views.QualForm exposing (..)
import Views.Comments exposing (..)


view : Model -> Html Msg
view model =
    let
        view =
            getCurrentView model
    in
        div [ class "w-100 fixed overflow-y-scroll top-0 bottom-0 bg-light-blue m0-auto cover", id "container" ]
            [ view
            ]


getCurrentView : Model -> Html Msg
getCurrentView model =
    case model.view of
        HomeView ->
            homeView model

        QuantFormView ->
            quantFormView model

        SnapshotView ->
            snapshotView model

        QualFormView ->
            qualFormView model

        CommentsView ->
            commentsView model


getView : String -> View
getView hash =
    case hash of
        "#home" ->
            HomeView

        "#numbers" ->
            QuantFormView

        "#numbers-snapshot" ->
            SnapshotView

        "#add-comment" ->
            QualFormView

        "#see-comments" ->
            CommentsView

        "#logout" ->
            HomeView

        _ ->
            HomeView


viewFromUrl : Navigation.Location -> Model -> Model
viewFromUrl location model =
    let
        view =
            getView location.hash
    in
        { model | view = view }
