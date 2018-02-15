module State exposing (..)

import Data.PostComment exposing (..)
import Data.PostStats exposing (..)
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
    , role = CaseWorker
    , weeklyCount = Nothing
    , peopleSeenWeekly = 0
    , peopleTurnedAwayWeekly = 0
    , commentBody = ""
    , commentType = Success
    , commentFilter = Nothing
    , comments = Nothing
    , commentStatus = NotAsked
    , statsStatus = NotAsked
    , peopleSeenWeeklyAll = 0
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

        UpdateRole role ->
            { model | role = role } ! []

        UpdatePeopleTurnedAway number ->
            { model | peopleTurnedAwayWeekly = Result.withDefault 0 (String.toInt number) } ! []

        UpdatePeopleSeen number ->
            { model | peopleSeenWeekly = Result.withDefault 0 (String.toInt number) } ! []

        PostComment ->
            { model | commentStatus = Loading } ! [ postComment model ]

        PostStats ->
            { model | statsStatus = Loading } ! [ postStats model ]

        ReceiveCommentStatus (Ok bool) ->
            { model | commentStatus = ResponseSuccess } ! []

        ReceiveCommentStatus (Err err) ->
            { model | commentStatus = ResponseFailure } ! []

        ReceiveStats (Ok response) ->
            { model | statsStatus = ResponseSuccess, peopleSeenWeeklyAll = response.peopleSeen } ! []

        ReceiveStats (Err response) ->
            { model | statsStatus = ResponseFailure } ! []
