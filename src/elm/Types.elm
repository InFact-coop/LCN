module Types exposing (..)

import Http
import Navigation
import Time exposing (Time)


type View
    = Home
    | AddStats
    | Snapshot
    | AddComment
    | ListComments


type alias Model =
    { view : View
    , name : String
    , lawCentre : LawCentre
    , lawArea : LawArea
    , role : Role
    , weeklyCount : Maybe Int
    , peopleSeenWeekly : Int
    , peopleTurnedAwayWeekly : Int
    , commentBody : String
    , commentType : CommentType
    , commentFilter : Maybe CommentType
    , comments : List Comment
    , commentStatus : RemoteData
    , postStatsStatus : RemoteData
    , listStatsStatus : RemoteData
    , peopleSeenWeeklyAll : Int
    , displayStatsModal : Bool
    }


type RemoteData
    = NotAsked
    | Loading
    | ResponseFailure
    | ResponseSuccess


type alias Comment =
    { id : CommentId
    , parentId : Maybe CommentId
    , name : String
    , lawCentre : LawCentre
    , commentBody : String
    , likes : Int
    , commentType : CommentType
    , lawArea : LawArea
    , createdAt : Time
    , showReplyInput : Bool
    }


type alias CommentId =
    String


type LawCentre
    = Camden
    | NoCentre


type Role
    = CaseWorker
    | Management
    | Triage
    | NoRole


type LawArea
    = Criminal
    | Immigration
    | NoArea


type CommentType
    = Trend
    | Success
    | Annoyance
    | AskUs
    | NoType


type alias StatsResponse =
    { postSuccess : Bool
    , getSuccess : Bool
    , peopleSeen : Int
    }


type Msg
    = NoOp
    | UrlChange Navigation.Location
    | UpdateCommentType CommentType
    | UpdateName String
    | UpdateLawArea LawArea
    | UpdateCommentBody String
    | UpdatePeopleSeen String
    | UpdatePeopleTurnedAway String
    | UpdateLawCentre LawCentre
    | UpdateRole Role
    | ReceiveCommentStatus (Result Http.Error Bool)
    | ReceiveStats (Result Http.Error StatsResponse)
    | PostComment
    | PostStats
    | ToggleStatsModal
    | ReceiveComments (Result Http.Error (List Comment))
    | ToggleReplyComponent Comment
