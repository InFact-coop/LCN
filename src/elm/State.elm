module State exposing (..)

import Data.Comment exposing (toggleReplyComponent)
import Dom.Scroll exposing (..)
import Navigation exposing (..)
import Requests.GetComments exposing (getComments)
import Requests.PostComment exposing (..)
import Requests.PostStats exposing (..)
import Router exposing (getView, viewFromUrl)
import Task
import Types exposing (..)
import Router exposing (getView)
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
    , comments = []
    , commentStatus = NotAsked
    , postStatsStatus = NotAsked
    , listStatsStatus = NotAsked
    , peopleSeenWeeklyAll = 0
    , displayStatsModal = False
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
            { model | view = getView location.hash, displayStatsModal = False }
                ! [ Task.attempt (always NoOp) (toTop "container")
                  , handleGetComments location
                  ]

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
            { model | postStatsStatus = Loading, listStatsStatus = Loading } ! [ postStats model ]

        ReceiveCommentStatus (Ok bool) ->
            { model | commentStatus = ResponseSuccess } ! [ getComments ]

        ReceiveCommentStatus (Err err) ->
            { model | commentStatus = ResponseFailure } ! [ getComments ]

        ReceiveStats (Ok response) ->
            if response.getSuccess == True then
                { model | postStatsStatus = ResponseSuccess, listStatsStatus = ResponseSuccess, peopleSeenWeeklyAll = response.peopleSeen, displayStatsModal = True } ! []
            else
                { model | postStatsStatus = ResponseSuccess, listStatsStatus = ResponseFailure, displayStatsModal = True } ! []

        ReceiveStats (Err response) ->
            { model | postStatsStatus = ResponseFailure, listStatsStatus = ResponseFailure, displayStatsModal = True } ! []

        ToggleStatsModal ->
            { model | displayStatsModal = False } ! []

        ReceiveComments (Ok comments) ->
            { model | comments = comments } ! []

        ReceiveComments (Err err) ->
            model ! []

        ToggleReplyComponent comment ->
            { model | comments = toggleReplyComponent model comment } ! []


handleGetComments : Navigation.Location -> Cmd Msg
handleGetComments location =
    let
        currentView =
            getView location.hash
    in
        case currentView of
            ListComments ->
                getComments

            _ ->
                Cmd.none
