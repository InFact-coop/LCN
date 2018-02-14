module State exposing (..)

import Dom.Scroll exposing (..)
import Router exposing (getView, viewFromUrl)
import Task
import Types exposing (..)
import Navigation exposing (..)


initModel : Model
initModel =
    { view = Home
    , name = ""
    , lawCentre = Nothing
    , lawArea = Nothing
    , role = Nothing
    , weeklyCount = Nothing
    , peopleSeenWeekly = 0
    , peopleTurnedAwayWeekly = 0
    , commentBody = ""
    , commentType = Nothing
    , commentFilter = Nothing
    , comments = Nothing
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        model =
            viewFromUrl location initModel
    in
        model ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            { model | view = getView location.hash } ! [ Task.attempt (always NoOp) (toTop "container") ]

        NoOp ->
            model ! []

        UpdateName username ->
            { model | name = username } ! []

        UpdateCommentType commentType ->
            { model | commentType = Just commentType } ! []

        UpdateCommentBody commentBody ->
            { model | commentBody = commentBody } ! []
