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
    , userCommentBody : String
    , userCommentType : Maybe CommentType
    , commentFilter : Maybe CommentType
    , comments : Maybe CommentType
    }


type alias QualForm =
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
    | AboutUs


type Msg
    = NoOp
    | UrlChange Navigation.Location
    | UpdateCommentType CommentType
    | UpdateName String
