module State exposing (..)

import Data.Comment exposing (toggleReplyComponent)
import Helpers exposing (ifThenElse, isNewEntry, scrollToTop)
import Json.Decode exposing (bool)
import Navigation exposing (..)
import Requests.GetComments exposing (getComments, handleGetComments)
import Requests.GetUserDetails exposing (getUserDetails)
import Requests.PostComment exposing (..)
import Requests.PostNewUserDetails exposing (postNewUserDetails)
import Requests.PostReply exposing (postReply)
import Requests.PostStats exposing (postStats)
import Router exposing (getView, viewFromUrl)
import Types exposing (..)


initModel : Model
initModel =
    { view = SplashScreen
    , name = ""
    , lawCentre = NoCentre
    , lawArea = NoArea
    , role = NoRole
    , weeklyCount = Nothing
    , peopleSeenWeekly = -1
    , peopleTurnedAwayWeekly = -1
    , newCasesWeekly = -1
    , signpostedExternallyWeekly = -1
    , signpostedInternallyWeekly = -1
    , commentBody = ""
    , commentType = Success
    , comments = []
    , commentStatus = NotAsked
    , postStatsStatus = NotAsked
    , listStatsStatus = NotAsked
    , peopleSeenWeeklyAll = 0
    , displayStatsModal = False
    , displayCommentModal = False
    , problems = []
    , agencies = []
    , submitEnabled = False
    , postUserDetailsStatus = NotAsked
    , getUserDetailsStatus = NotAsked
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        model =
            viewFromUrl location initModel
    in
        model
            ! [ handleGetComments location
              , getUserDetails
              ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            { model
                | view = getView location.hash
                , displayStatsModal = False
                , displayCommentModal = False
                , submitEnabled = False
                , peopleSeenWeekly = -1
                , peopleTurnedAwayWeekly = -1
                , newCasesWeekly = -1
                , signpostedInternallyWeekly = -1
                , signpostedExternallyWeekly = -1
            }
                ! [ scrollToTop, handleGetComments location ]

        NoOp ->
            model ! []

        UpdateLawArea la ->
            let
                updatedModel =
                    { model | lawArea = la }
            in
                submitEnabledToModel updatedModel ! []

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
            let
                updatedModel =
                    { model
                        | role = role
                    }
            in
                submitEnabledToModel updatedModel ! []

        UpdatePeopleTurnedAway number ->
            let
                updatedModel =
                    { model | peopleTurnedAwayWeekly = Result.withDefault -1 (String.toInt number) }
            in
                submitEnabledToModel updatedModel ! []

        UpdatePeopleSeen number ->
            let
                updatedModel =
                    { model | peopleSeenWeekly = Result.withDefault -1 (String.toInt number) }
            in
                submitEnabledToModel updatedModel ! []

        UpdateNewCases number ->
            let
                updatedModel =
                    { model | newCasesWeekly = Result.withDefault -1 (String.toInt number) }
            in
                submitEnabledToModel updatedModel ! []

        UpdateSignpostedInterally number ->
            let
                updatedModel =
                    { model | signpostedInternallyWeekly = Result.withDefault -1 (String.toInt number) }
            in
                submitEnabledToModel updatedModel ! []

        UpdateSignpostedExternally number ->
            let
                updatedModel =
                    { model | signpostedExternallyWeekly = Result.withDefault -1 (String.toInt number) }
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
                { model
                    | commentStatus = ResponseSuccess
                    , displayCommentModal = displayModal
                    , commentBody = ""
                }
                    ! [ getComments, scrollToTop ]

        ReceiveCommentStatus (Err err) ->
            { model | commentStatus = ResponseFailure } ! [ getComments, scrollToTop ]

        ReceiveStats (Ok response) ->
            if response.getSuccess then
                { model
                    | postStatsStatus = ResponseSuccess
                    , listStatsStatus = ResponseSuccess
                    , peopleSeenWeeklyAll = response.peopleSeen
                    , displayStatsModal = True
                }
                    ! [ scrollToTop ]
            else
                { model
                    | postStatsStatus = ResponseSuccess
                    , listStatsStatus = ResponseFailure
                    , displayStatsModal = True
                }
                    ! [ scrollToTop ]

        ReceiveStats (Err response) ->
            { model
                | postStatsStatus = ResponseFailure
                , listStatsStatus = ResponseFailure
                , displayStatsModal = True
            }
                ! []

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

        ToggleAgency string checked ->
            if checked && isNewEntry string model.agencies then
                { model | agencies = model.agencies ++ [ string ] } ! []
            else
                { model | agencies = List.filter (\x -> x /= string) model.agencies } ! []

        ToggleReplyComponent comment ->
            { model | comments = toggleReplyComponent model comment } ! []

        PostReply parentComment ->
            model ! [ postReply model parentComment ]

        PostUserDetailsStatus (Ok bool) ->
            { model | view = AddStats, postUserDetailsStatus = ResponseSuccess } ! []

        PostUserDetailsStatus (Err err) ->
            { model | postUserDetailsStatus = ResponseFailure } ! []

        PostNewUserDetails ->
            let
                updatedModel =
                    { model | postUserDetailsStatus = Loading, lawArea = ifThenElse (model.role == CaseWorker) model.lawArea NoArea }
            in
                updatedModel ! [ postNewUserDetails updatedModel ]

        GetUserDetailsStatus (Ok { name, lawCentre, lawArea, role }) ->
            { model | name = name, lawCentre = lawCentre, lawArea = lawArea, role = role, getUserDetailsStatus = ResponseSuccess, view = ifThenElse (lawCentre == NoCentre || role == NoRole) BeforeYouBegin AddStats }
                ! []

        GetUserDetailsStatus (Err err) ->
            let
                debugit =
                    Debug.log "User Details Error" err
            in
                { model | getUserDetailsStatus = ResponseFailure, view = BeforeYouBegin } ! []


submitEnabledToModel : Model -> Model
submitEnabledToModel model =
    let
        trueModel =
            { model | submitEnabled = True }

        falseModel =
            { model | submitEnabled = False }
    in
        case model.view of
            AddStats ->
                case model.role of
                    CaseWorker ->
                        ifThenElse
                            ((model.lawArea /= NoArea)
                                && (model.peopleSeenWeekly /= -1)
                                && (model.newCasesWeekly /= -1)
                                && (not <| List.isEmpty model.problems)
                            )
                            trueModel
                            falseModel

                    Triage ->
                        ifThenElse
                            ((model.peopleSeenWeekly /= -1)
                                && (model.peopleTurnedAwayWeekly /= -1)
                                && (model.signpostedInternallyWeekly /= -1)
                                && (model.signpostedExternallyWeekly /= -1)
                                && (not <| List.isEmpty model.problems)
                            )
                            trueModel
                            falseModel

                    _ ->
                        ifThenElse (model.peopleSeenWeekly /= -1) trueModel falseModel

            BeforeYouBegin ->
                case model.role of
                    CaseWorker ->
                        ifThenElse
                            ((model.lawArea /= NoArea)
                                && (model.lawCentre /= NoCentre)
                            )
                            trueModel
                            falseModel

                    _ ->
                        ifThenElse
                            (model.lawCentre
                                /= NoCentre
                                && model.role
                                /= NoRole
                            )
                            trueModel
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

            SplashScreen ->
                falseModel
