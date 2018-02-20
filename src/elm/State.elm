module State exposing (..)

import Data.Comment exposing (toggleReplyComponent)
import Helpers exposing (scrollToTop)
import Navigation exposing (..)
import Requests.GetComments exposing (getComments, handleGetComments)
import Requests.PostComment exposing (..)
import Requests.PostReply exposing (postReply)
import Requests.PostStats exposing (..)
import Router exposing (getView, viewFromUrl)
import Types exposing (..)


initModel : Model
initModel =
    { view = Home
    , name = ""
    , lawCentre = Camden
    , lawArea = NoArea
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
    , problems = []
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
                ! [ scrollToTop, handleGetComments location ]

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
            { model | commentStatus = ResponseSuccess } ! [ getComments, scrollToTop ]

        ReceiveCommentStatus (Err err) ->
            { model | commentStatus = ResponseFailure } ! [ getComments, scrollToTop ]

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

        ToggleProblem string checked ->
            if checked && isNewEntry string model.problems then
                { model | problems = model.problems ++ [ string ] } ! []
            else
                { model | problems = List.filter (\x -> x /= string) model.problems } ! []

        ToggleReplyComponent comment ->
            { model | comments = toggleReplyComponent model comment } ! []

        PostReply parentComment ->
            model ! [ postReply model parentComment ]


isNewEntry : String -> List String -> Bool
isNewEntry string stringList =
    List.member string stringList
        |> not
