module State exposing (init, initModel, subscriptions, update, updateCommentLikes)

import Data.Comment exposing (toggleReplyComponent, updateCommentLikes)
import Data.Role exposing (updateRoles)
import Helpers exposing (ifThenElse, isNewEntry, scrollToTop)
import Navigation exposing (..)
import Process exposing (sleep)
import Requests.GetComments exposing (getComments, handleGetComments)
import Requests.GetUserDetails exposing (getUserDetails)
import Requests.PostComment exposing (..)
import Requests.PostNewUserDetails exposing (postNewUserDetails)
import Requests.PostReply exposing (postReply)
import Requests.PostStats exposing (postStats)
import Requests.PostUpvote exposing (postUpvote)
import Router exposing (getHash, getView, viewFromUrl)
import Task exposing (perform)
import Time exposing (..)
import Types exposing (..)


initStatsResponse : StatsData
initStatsResponse =
    { clientMatters = Nothing
    , clientMattersByArea = Nothing
    , enquiries = Nothing
    , vacancies = Nothing
    , mediaCoverage = Nothing
    , lawyerVolunteers = Nothing
    , studentVolunteers = Nothing
    }


initModel : Model
initModel =
    { view = SplashScreen
    , name = ""
    , lawCentre = NoCentre
    , lawArea = NoArea
    , roles = [ NoRole ]
    , isAdmin = False
    , weeklyCount = 0
    , peopleTurnedAwayWeekly = 0
    , newCasesWeekly = 0
    , signpostedExternallyWeekly = 0
    , signpostedInternallyWeekly = 0
    , internalAppointmentsWeekly = 0
    , enquiriesWeekly = 0
    , clientMattersWeekly = 0
    , commentBody = ""
    , commentType = Success
    , comments = []
    , postCommentStatus = NotAsked
    , postStatsStatus = NotAsked
    , listStatsStatus = NotAsked
    , listCommentsStatus = NotAsked
    , displayStatsModal = False
    , displayCommentModal = False
    , displayHelpModal = False
    , displayHelpInfo = False
    , problems = []
    , agencies = []
    , postUserDetailsStatus = NotAsked
    , postUpvoteStatus = NotAsked
    , getUserDetailsStatus = NotAsked
    , volunteersTotalWeekly = 0
    , studentVolunteersWeekly = 0
    , lawyerVolunteersWeekly = 0
    , vacanciesWeekly = 0
    , mediaCoverageWeekly = 0
    , statsResponse = initStatsResponse
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
            let
                view =
                    getView location.hash
            in
            { model
                | view = view
                , displayCommentModal = False
                , clientMattersWeekly = 0
                , enquiriesWeekly = 0
                , peopleTurnedAwayWeekly = 0
                , newCasesWeekly = 0
                , signpostedInternallyWeekly = 0
                , signpostedExternallyWeekly = 0
                , displayHelpModal = False
                , displayHelpInfo = view == BeforeYouBegin
            }
                ! [ scrollToTop, ifThenElse (view == ListComments) (msgToCmd GetComments) Cmd.none ]

        EditStats ->
            { model | postStatsStatus = NotAsked } ! []

        ToggleHelpModal ->
            { model | displayHelpModal = not model.displayHelpModal } ! []

        NoOp ->
            model ! []

        ToggleHelpInfo ->
            { model | displayHelpInfo = not model.displayHelpInfo } ! []

        UpdateLawArea la ->
            let
                updatedModel =
                    { model | lawArea = la }
            in
            updatedModel ! []

        UpdateName username ->
            let
                updatedModel =
                    { model | name = username }
            in
            updatedModel ! []

        UpdateCommentType commentType ->
            { model | commentType = commentType } ! []

        UpdateCommentBody commentBody ->
            let
                updatedModel =
                    { model | commentBody = commentBody }
            in
            updatedModel ! []

        UpdateLawCentre lc ->
            let
                updatedModel =
                    { model | lawCentre = lc }
            in
            updatedModel ! []

        UpdateRoles role ->
            let
                updatedModel =
                    { model
                        | roles = updateRoles model role
                    }
            in
            updatedModel ! []

        UpdatePeopleTurnedAway number ->
            let
                updatedModel =
                    { model | peopleTurnedAwayWeekly = max (Result.withDefault 0 (String.toInt number)) 0 }
            in
            updatedModel ! []

        UpdateEnquiries number ->
            let
                updatedModel =
                    { model | enquiriesWeekly = max (Result.withDefault 0 (String.toInt number)) 0 }
            in
            updatedModel ! []

        UpdateClientMatters number ->
            let
                updatedModel =
                    { model | clientMattersWeekly = max (Result.withDefault 0 (String.toInt number)) 0 }
            in
            updatedModel ! []

        UpdateNewCases number ->
            let
                updatedModel =
                    { model | newCasesWeekly = max (Result.withDefault 0 (String.toInt number)) 0 }
            in
            updatedModel ! []

        UpdateSignpostedInternally number ->
            let
                updatedModel =
                    { model | signpostedInternallyWeekly = max (Result.withDefault 0 (String.toInt number)) 0 }
            in
            updatedModel ! []

        UpdateInternalAppointments number ->
            let
                updatedModel =
                    { model | internalAppointmentsWeekly = max (Result.withDefault 0 (String.toInt number)) 0 }
            in
            updatedModel ! []

        UpdateSignpostedExternally number ->
            let
                updatedModel =
                    { model | signpostedExternallyWeekly = max (Result.withDefault 0 (String.toInt number)) 0 }
            in
            updatedModel ! []

        PostComment ->
            { model | postCommentStatus = Loading } ! [ postComment model ]

        PostStats ->
            { model | postStatsStatus = Loading, listStatsStatus = Loading } ! [ postStats model ]

        ConfirmStats ->
            { model | postStatsStatus = UserConfirmation, listStatsStatus = UserConfirmation } ! []

        ReceiveCommentStatus (Ok bool) ->
            let
                displayModal =
                    ifThenElse (model.view == AddComment) True False
            in
            { model
                | postCommentStatus = ResponseSuccess
                , displayCommentModal = displayModal
                , commentBody = ""
            }
                ! [ getComments, scrollToTop ]

        ReceiveCommentStatus (Err err) ->
            { model | postCommentStatus = ResponseFailure } ! [ getComments, scrollToTop ]

        ReceiveStats (Ok response) ->
            if response.getSuccess then
                { model
                    | postStatsStatus = ResponseSuccess
                    , listStatsStatus = ResponseSuccess
                    , statsResponse = response.statsResponse
                    , displayStatsModal = True
                }
                    ! [ scrollToTop, newUrl "/#list-comments", delay (Time.second * 3) ToggleStatsModal ]

            else
                { model
                    | postStatsStatus = ResponseSuccess
                    , listStatsStatus = ResponseFailure
                    , displayStatsModal = True
                }
                    ! [ scrollToTop, newUrl "/#list-comments", delay (Time.second * 3) ToggleStatsModal ]

        ReceiveStats (Err response) ->
            { model
                | postStatsStatus = ResponseFailure
                , listStatsStatus = ResponseFailure
                , displayStatsModal = False
            }
                ! []

        ToggleStatsModal ->
            { model | displayStatsModal = False } ! []

        GetComments ->
            { model | listCommentsStatus = Loading } ! [ getComments ]

        ReceiveComments (Err err) ->
            { model
                | listCommentsStatus = ResponseFailure
            }
                ! []

        ReceiveComments (Ok comments) ->
            { model
                | comments = comments
                , listCommentsStatus = ResponseSuccess
            }
                ! []

        ToggleProblem string checked ->
            let
                updatedModel =
                    if checked && isNewEntry string model.problems then
                        { model | problems = model.problems ++ [ string ] }

                    else
                        { model | problems = List.filter (\x -> x /= string) model.problems }
            in
            updatedModel ! []

        ToggleAgency string checked ->
            let
                updatedModel =
                    ifThenElse (checked && isNewEntry string model.agencies)
                        { model | agencies = model.agencies ++ [ string ] }
                        { model | agencies = List.filter (\x -> x /= string) model.agencies }
            in
            updatedModel ! []

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
                    { model
                        | postUserDetailsStatus = Loading
                        , lawArea = ifThenElse (List.member CaseWorker model.roles) model.lawArea NoArea
                    }
            in
            updatedModel ! [ postNewUserDetails updatedModel ]

        GetUserDetailsStatus (Ok { name, lawCentre, lawArea, roles, admin }) ->
            { model
                | name = name
                , lawCentre = lawCentre
                , lawArea = lawArea
                , roles = roles
                , isAdmin = admin
                , getUserDetailsStatus = ResponseSuccess
                , view = ifThenElse (lawCentre == NoCentre || roles == [ NoRole ]) BeforeYouBegin AddStats
            }
                ! []

        GetUserDetailsStatus (Err err) ->
            { model | getUserDetailsStatus = ResponseFailure, view = BeforeYouBegin } ! []

        UpdateStudentVolunteersWeekly number ->
            let
                updatedModel =
                    { model | studentVolunteersWeekly = max (Result.withDefault 0 (String.toInt number)) 0 }
            in
            updatedModel ! []

        UpdateLawyerVolunteersWeekly number ->
            let
                updatedModel =
                    { model | lawyerVolunteersWeekly = max (Result.withDefault 0 (String.toInt number)) 0 }
            in
            updatedModel ! []

        UpdateVacanciesWeekly number ->
            let
                updatedModel =
                    { model | vacanciesWeekly = max (Result.withDefault 0 (String.toInt number)) 0 }
            in
            updatedModel ! []

        UpdateMediaCoverageWeekly number ->
            let
                updatedModel =
                    { model | mediaCoverageWeekly = max (Result.withDefault 0 (String.toInt number)) 0 }
            in
            updatedModel ! []

        UpvoteComment comment ->
            { model | postUpvoteStatus = Loading } ! [ postUpvote comment.id ]

        ReceiveUpvoteStatus (Ok upvote) ->
            { model | postUpvoteStatus = ResponseSuccess, comments = List.map (updateCommentLikes upvote) model.comments } ! []

        ReceiveUpvoteStatus (Err err) ->
            { model | postUpvoteStatus = ResponseFailure } ! []


delay : Time -> Msg -> Cmd Msg
delay time msg =
    sleep time
        |> perform (\_ -> msg)


msgToCmd : Msg -> Cmd Msg
msgToCmd msg =
    Task.succeed msg
        |> Task.perform identity


updateCommentLikes : UpvoteResponse -> Comment -> Comment
updateCommentLikes upvote comment =
    { comment
        | likes =
            ifThenElse (comment.id == upvote.commentId)
                upvote.commentLikes
                comment.likes
        , likedByUser =
            ifThenElse
                (comment.id
                    == upvote.commentId
                    || comment.likedByUser
                    == True
                )
                True
                False
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []
