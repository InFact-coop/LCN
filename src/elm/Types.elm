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
    , commentFilter : Maybe CommentType
    , comments : Maybe (List QualForm)
    , userCommentBody : String
    , userCommentType : Maybe CommentType
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


type Msg
    = NoOp
    | UrlChange Navigation.Location
    | UpdateCommentType CommentType
