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
    , role : Maybe Role
    , lawArea : Maybe LawArea
    , weeklyCount : Maybe Int
    , peopleSeenWeekly : Int
    , peopleTurnedAwayWeekly : Int
    , commentBody : String
    , commentFilter : Maybe CommentType
    , commentType : Maybe CommentType
    , comments : Maybe (List QualForm)
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
    | AboutUs


type Msg
    = NoOp
    | UrlChange Navigation.Location
    | UpdateName String
    | UpdateLawCentre LawCentre
