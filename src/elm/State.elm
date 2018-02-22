module State exposing (..)

import Data.Comment exposing (toggleReplyComponent)
import Helpers exposing (ifThenElse, scrollToTop)
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
    , lawCentre = NoCentre
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
    , displayCommentModal = False
    , problems = []
    , submitEnabled = False
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
    let
        submitCheck =
            { model | submitEnabled = submitEnabledToModel model }
    in
        case msg of
            UrlChange location ->
                { model | view = getView location.hash, displayStatsModal = False, displayCommentModal = False, submitEnabled = False }
                    ! [ scrollToTop, handleGetComments location ]

            NoOp ->
                model ! []

            UpdateLawArea la ->
                { model | lawArea = la } ! []

            UpdateName username ->
                let
                    updatedModel =
                        { model | name = username }
                in
                    submitEnabledToModel updatedModel ! []

            UpdateCommentType commentType ->
                { model | commentType = commentType } ! []

            UpdateCommentBody commentBody ->
                let
                    updatedModel =
                        { model | commentBody = commentBody }
                in
                    submitEnabledToModel updatedModel ! []

            UpdateLawCentre lc ->
                let
                    updatedModel =
                        { model | lawCentre = lc }
                in
                    submitEnabledToModel updatedModel ! []

            UpdateRole role ->
                { model | role = role } ! []

            UpdatePeopleTurnedAway number ->
                let
                    updatedModel =
                        { model | peopleTurnedAwayWeekly = Result.withDefault 0 (String.toInt number) }
                in
                    submitEnabledToModel updatedModel ! []

            UpdatePeopleSeen number ->
                let
                    updatedModel =
                        { model | peopleSeenWeekly = Result.withDefault 0 (String.toInt number) }
                in
                    submitEnabledToModel updatedModel ! []

            PostComment ->
                { model | commentStatus = Loading } ! [ postComment model ]

            PostStats ->
                { model | postStatsStatus = Loading, listStatsStatus = Loading } ! [ postStats model ]

            ReceiveCommentStatus (Ok bool) ->
                let
                    displayModal =
                        ifThenElse (model.view == AddComment) True False
                in
                    { model | commentStatus = ResponseSuccess, displayCommentModal = displayModal, commentBody = "" } ! [ getComments, scrollToTop ]

            ReceiveCommentStatus (Err err) ->
                { model | commentStatus = ResponseFailure } ! [ getComments, scrollToTop ]

            ReceiveStats (Ok response) ->
                if response.getSuccess then
                    { model | postStatsStatus = ResponseSuccess, listStatsStatus = ResponseSuccess, peopleSeenWeeklyAll = response.peopleSeen, displayStatsModal = True } ! [ scrollToTop ]
                else
                    { model | postStatsStatus = ResponseSuccess, listStatsStatus = ResponseFailure, displayStatsModal = True } ! [ scrollToTop ]

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


submitEnabledToModel : Model -> Model
submitEnabledToModel model =
    let
        trueModel =
            { model | submitEnabled = True }

        falseModel =
            { model | submitEnabled = False }
    in
        case model.view of
            Home ->
                ifThenElse
                    (model.name /= "" && model.lawCentre /= NoCentre)
                    trueModel
                    falseModel

            AddStats ->
                ifThenElse
                    (model.peopleSeenWeekly /= 0 && model.peopleTurnedAwayWeekly /= 0)
                    (ifThenElse (model.role /= CaseWorker)
                        trueModel
                        (ifThenElse
                            (model.lawArea /= NoArea)
                            trueModel
                            falseModel
                        )
                    )
                    falseModel

            Snapshot ->
                falseModel

            AddComment ->
                ifThenElse
                    (model.commentBody /= "")
                    trueModel
                    falseModel

            ListComments ->
                falseModel
