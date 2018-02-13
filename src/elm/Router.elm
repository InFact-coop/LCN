module Router exposing (..)

import Components.Nav exposing (navBar)
import Html exposing (..)
import Html.Attributes exposing (..)
import Navigation exposing (..)
import Types exposing (..)
import Views.Home exposing (..)


view : Model -> Html Msg
view model =
    let
        view =
            getCurrentView model
    in
        div [ class "w-100 fixed overflow-y-scroll top-0 bottom-0 bg-light-blue m0-auto cover", id "container" ]
            [ navBar
            , view
            ]


getCurrentView : Model -> Html Msg
getCurrentView model =
    case model.view of
        Home ->
            home model


getView : String -> View
getView hash =
    case hash of
        "#home" ->
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
