module Types exposing (..)

import Navigation


type View
    = Home
    | AddStats
    | Snapshot
    | AddComment
    | ListComments


type alias Model =
    { view : View
    , name : String
    , lawCentre : Maybe LawCentre
    , lawArea : Maybe LawArea
    , role : Maybe Role
    , weeklyCount : Maybe Int
    , peopleSeenWeekly : Int
    , peopleTurnedAwayWeekly : Int
    , commentBody : String
    , commentType : CommentType
    , commentFilter : Maybe CommentType
    , comments : Maybe (List Comment)
    }


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
    | None


type Role
    = CaseWorker
    | Management
    | Triage


type LawArea
    = Criminal


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
    | UpdateCommentBody String
    | UpdateLawCentre LawCentre
