module Types exposing (..)

import Navigation
import Http


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
    , comments : Maybe (List Comment)
    , commentStatus : RemoteData
    , statsStatus : RemoteData
    , peopleSeenWeeklyAll : Int
    }


type RemoteData
    = NotAsked
    | Loading
    | ResponseFailure
    | ResponseSuccess


type alias Comment =
    { id : Maybe Int
    , parentId : Maybe Int
    , name : String
    , lawCentre : Maybe LawCentre
    , commentBody : String
    , likes : Int
    , commentType : Maybe CommentType
    , lawArea : Maybe LawArea
    }


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
