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
    , role : Maybe Role
    , weeklyCount : Maybe Int
    , peopleSeenWeekly : Int
    , peopleTurnedAwayWeekly : Int
    , commentBody : String
    , commentType : CommentType
    , commentFilter : Maybe CommentType
    , comments : List Comment
    , commentStatus : RemoteData
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
    , lawCentre : LawCentre
    , commentBody : String
    , likes : Int
    , commentType : CommentType
    , lawArea : Maybe LawArea
    }


type LawCentre
    = Camden
    | NoCentre


type Role
    = CaseWorker
    | Management
    | Triage


type LawArea
    = Criminal
    | Immigration
    | NoArea


type CommentType
    = Trend
    | Success
    | Annoyance
    | AskUs


type Msg
    = NoOp
    | UrlChange Navigation.Location
    | UpdateCommentType CommentType
    | UpdateName String
    | UpdateLawArea LawArea
    | UpdateCommentBody String
    | UpdateLawCentre LawCentre
    | ReceiveCommentStatus (Result Http.Error Bool)
    | PostComment
