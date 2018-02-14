module State exposing (..)

import Data.PostComment exposing (..)
import Dom.Scroll exposing (..)
import Navigation exposing (..)
import Router exposing (getView, viewFromUrl)
import Task
import Types exposing (..)


initModel : Model
initModel =
    { view = Home
    , name = ""
    , lawCentre = Camden
    , lawArea = Immigration
    , role = Nothing
    , weeklyCount = Nothing
    , peopleSeenWeekly = 0
    , peopleTurnedAwayWeekly = 0
    , commentBody = ""
    , commentType = Success
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

        UpdateLawArea la ->
            { model | lawArea = la } ! []

        UpdateName username ->
            { model | name = username } ! []

        UpdateCommentType commentType ->
            { model | commentType = commentType } ! []

        UpdateCommentBody commentBody ->
            { model | commentBody = commentBody } ! []

        UpdateLawCentre lc ->
            { model | lawCentre = lc } ! []

        PostComment ->
            model ! [ postComment model ]

        ReceiveCommentStatus (Ok string) ->
            model ! []

        ReceiveCommentStatus (Err err) ->
            model ! []
