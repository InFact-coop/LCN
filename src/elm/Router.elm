module Router exposing (getCurrentView, getHash, getView, modalBackground, view, viewFromUrl)

import Components.CommentModal exposing (commentModal)
import Components.Nav exposing (navBar)
import Components.StatsModal exposing (statsModal)
import Components.StyleHelpers exposing (classes, displayElement)
import Html exposing (..)
import Html.Attributes exposing (..)
import Navigation exposing (..)
import Types exposing (..)
import Views.About exposing (..)
import Views.AddComment exposing (..)
import Views.AddStats exposing (..)
import Views.BeforeYouBegin exposing (..)
import Views.ListComments exposing (..)
import Views.SplashScreen exposing (..)


view : Model -> Html Msg
view model =
    let
        view =
            getCurrentView model

        activeLink =
            "/" ++ getHash model.view
    in
    div [ class "w-100 fixed overflow-y-scroll top-0 bottom-0 bg-light-blue m0-auto cover", id "container" ]
        [ modalBackground model
        , helpButton
        , statsModal model
        , commentModal model
        , div [ class "fixed w-100 bg-white flex flex-row justify-center z-1" ] [ navBar model activeLink ]
        , div [ class "mt6 center pt3-ns mw8" ] [ view ]
        ]


helpButton : Html Msg
helpButton =
    button [ class "bn shadow-4 br-100 h4 w4 fixed right-2 top-8 pointer", style [ ( "background", "url(./assets/help_icon.svg) no-repeat center center white" ) ] ] []


modalBackground : Model -> Html Msg
modalBackground model =
    div
        [ classes
            [ "vh-100 w-100 bg-black o-70 z-2 fixed"
            , displayElement (model.displayStatsModal || model.displayCommentModal)
            ]
        ]
        []


getCurrentView : Model -> Html Msg
getCurrentView model =
    case model.view of
        AddStats ->
            addStatsView model

        About ->
            about model

        AddComment ->
            addCommentView model

        ListComments ->
            listCommentsView model

        BeforeYouBegin ->
            beforeYouBegin model

        SplashScreen ->
            splashScreen model


getView : String -> View
getView hash =
    case hash of
        "#numbers" ->
            AddStats

        "#about" ->
            About

        "#add-comment" ->
            AddComment

        "#list-comments" ->
            ListComments

        "#before-you-begin" ->
            BeforeYouBegin

        "#splash-screen" ->
            SplashScreen

        _ ->
            SplashScreen


getHash : View -> String
getHash view =
    case view of
        AddStats ->
            "#numbers"

        About ->
            "#about"

        AddComment ->
            "#add-comment"

        ListComments ->
            "#list-comments"

        BeforeYouBegin ->
            "#before-you-begin"

        SplashScreen ->
            "#splash-screen"


viewFromUrl : Navigation.Location -> Model -> Model
viewFromUrl location model =
    let
        view =
            getView location.hash
    in
    { model | view = view }
