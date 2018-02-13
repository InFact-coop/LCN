module Types exposing (..)

import Navigation


type View
    = Home


type alias Model =
    { view : View
    , name : String
    , lawCentre : Maybe LawCentre
    , role : Maybe Role
    , lawArea : Maybe LawArea
    , qualForm : QualForm
    , quantForm : QuantForm
    , weeklyCount : Maybe Int
    , commentFilter : Maybe CommentType
    , comments : Maybe (List QualForm)
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


type alias QuantForm =
    { name : String
    , lawCentre : Maybe LawCentre
    , lawArea : Maybe LawArea
    , peopleSeenWeekly : Int
    , peopleTurnedAwayWeekly : Int
    }


type Msg
    = NoOp
    | UrlChange Navigation.Location
