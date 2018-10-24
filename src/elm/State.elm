module State exposing (init, initModel, update)

import Data.Comment exposing (toggleReplyComponent, updateCommentLikes)
import Helpers exposing (ifThenElse, isNewEntry, scrollToTop)
import Navigation exposing (..)
import Requests.GetComments exposing (getComments, handleGetComments)
import Requests.GetUserDetails exposing (getUserDetails)
import Requests.PostComment exposing (..)
import Requests.PostNewUserDetails exposing (postNewUserDetails)
import Requests.PostReply exposing (postReply)
import Requests.PostStats exposing (postStats)
import Requests.PostUpvote exposing (postUpvote)
import Router exposing (getView, viewFromUrl)
import Types exposing (..)


initModel : Model
initModel =
    { view = SplashScreen
    , name = ""
    , lawCentre = NoCentre
    , lawArea = NoArea
    , role = [ NoRole ]
    , isAdmin = False
    , weeklyCount = Nothing
    , peopleSeenWeekly = Nothing
    , peopleTurnedAwayWeekly = Nothing
    , newCasesWeekly = Nothing
    , signpostedExternallyWeekly = Nothing
    , signpostedInternallyWeekly = Nothing
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
    , submitEnabled = True
    , postUserDetailsStatus = NotAsked
    , postUpvoteStatus = NotAsked
    , getUserDetailsStatus = NotAsked
    , volunteersTotalWeekly = Nothing
    , studentVolunteersWeekly = Nothing
    , lawyerVolunteersWeekly = Nothing
    , vacanciesWeekly = Nothing
    , mediaCoverageWeekly = Nothing
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
                , peopleSeenWeekly = Nothing
                , peopleTurnedAwayWeekly = Nothing
                , newCasesWeekly = Nothing
                , signpostedInternallyWeekly = Nothing
                , signpostedExternallyWeekly = Nothing
            }
                ! [ scrollToTop, handleGetComments location ]

        NoOp ->
            model ! []

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

        UpdateRole role ->
            let
                updatedModel =
                    { model
                        | role = model.role ++ [ role ]
                    }
            in
            updatedModel ! []

        UpdatePeopleTurnedAway number ->
            let
                updatedModel =
                    { model | peopleTurnedAwayWeekly = Just <| Result.withDefault 0 (String.toInt number) }
            in
            updatedModel ! []

        UpdatePeopleSeen number ->
            let
                updatedModel =
                    { model | peopleSeenWeekly = Just <| Result.withDefault 0 (String.toInt number) }
            in
            updatedModel ! []

        UpdateNewCases number ->
            let
                updatedModel =
                    { model | newCasesWeekly = Just <| Result.withDefault 0 (String.toInt number) }
            in
            updatedModel ! []

        UpdateSignpostedInternally number ->
            let
                updatedModel =
                    { model | signpostedInternallyWeekly = Just <| Result.withDefault 0 (String.toInt number) }
            in
            updatedModel ! []

        UpdateSignpostedExternally number ->
            let
                updatedModel =
                    { model | signpostedExternallyWeekly = Just <| Result.withDefault 0 (String.toInt number) }
            in
            updatedModel ! []

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
                        , lawArea = ifThenElse (List.member CaseWorker model.role) model.lawArea NoArea
                    }
            in
            updatedModel ! [ postNewUserDetails updatedModel ]

        GetUserDetailsStatus (Ok { name, lawCentre, lawArea, role, admin }) ->
            { model
                | name = name
                , lawCentre = lawCentre
                , lawArea = lawArea
                , role = role
                , isAdmin = admin
                , getUserDetailsStatus = ResponseSuccess
                , view = ifThenElse (lawCentre == NoCentre || role == [ NoRole ]) BeforeYouBegin AddStats
            }
                ! []

        GetUserDetailsStatus (Err err) ->
            { model | getUserDetailsStatus = ResponseFailure, view = BeforeYouBegin } ! []

        UpdateVolunteersTotalWeekly number ->
            let
                updatedModel =
                    { model | volunteersTotalWeekly = Just <| Result.withDefault 0 (String.toInt number) }
            in
            updatedModel ! []

        UpdateStudentVolunteersWeekly number ->
            let
                updatedModel =
                    { model | studentVolunteersWeekly = Just <| Result.withDefault 0 (String.toInt number) }
            in
            updatedModel ! []

        UpdateLawyerVolunteersWeekly number ->
            let
                updatedModel =
                    { model | lawyerVolunteersWeekly = Just <| Result.withDefault 0 (String.toInt number) }
            in
            updatedModel ! []

        UpdateVacanciesWeekly number ->
            let
                updatedModel =
                    { model | vacanciesWeekly = Just <| Result.withDefault 0 (String.toInt number) }
            in
            updatedModel ! []

        UpdateMediaCoverageWeekly number ->
            let
                updatedModel =
                    { model | mediaCoverageWeekly = Just <| Result.withDefault 0 (String.toInt number) }
            in
            updatedModel ! []

        UpvoteComment comment ->
            { model | postUpvoteStatus = Loading } ! [ postUpvote comment.id ]

        ReceiveUpvoteStatus (Ok upvote) ->
            { model | postUpvoteStatus = ResponseSuccess, comments = List.map (updateCommentLikes upvote) model.comments } ! []

        ReceiveUpvoteStatus (Err err) ->
            { model | postUpvoteStatus = ResponseFailure } ! []



-- submitEnabledToModel : Model -> Model
-- submitEnabledToModel model =
--     let
--         trueModel =
--             { model | submitEnabled = True }
--
--         falseModel =
--             { model | submitEnabled = False }
--     in
--     case model.view of
--         AddStats ->
--             case model.role of
--                 CaseWorker ->
--                     ifThenElse
--                         ((model.lawArea /= NoArea)
--                             && (model.peopleSeenWeekly /= Nothing)
--                             && (model.newCasesWeekly /= Nothing)
--                             && (not <| List.isEmpty model.problems)
--                         )
--                         trueModel
--                         falseModel
--
--                 Triage ->
--                     ifThenElse
--                         ((model.peopleSeenWeekly /= Nothing)
--                             && (model.peopleTurnedAwayWeekly /= Nothing)
--                             && (model.signpostedInternallyWeekly /= Nothing)
--                             && (model.signpostedExternallyWeekly /= Nothing)
--                             && (not <| List.isEmpty model.agencies)
--                         )
--                         trueModel
--                         falseModel
--
--                 Management ->
--                     ifThenElse
--                         (model.volunteersTotalWeekly
--                             /= Nothing
--                             && model.studentVolunteersWeekly
--                             /= Nothing
--                             && model.lawyerVolunteersWeekly
--                             /= Nothing
--                             && model.vacanciesWeekly
--                             /= Nothing
--                             && model.mediaCoverageWeekly
--                             /= Nothing
--                         )
--                         trueModel
--                         falseModel
--
--                 _ ->
--                     trueModel
--
--         BeforeYouBegin ->
--             case model.role of
--                 CaseWorker ->
--                     ifThenElse
--                         ((model.lawArea /= NoArea)
--                             && (model.lawCentre /= NoCentre)
--                         )
--                         trueModel
--                         falseModel
--
--                 _ ->
--                     ifThenElse
--                         (model.lawCentre
--                             /= NoCentre
--                             && model.role
--                             /= NoRole
--                         )
--                         trueModel
--                         falseModel
--
--         AddComment ->
--             ifThenElse
--                 (model.commentBody /= "")
--                 trueModel
--                 falseModel
--
--         ListComments ->
--             falseModel
--
--         SplashScreen ->
--             falseModel
