module Types exposing (..)

import Navigation


type View
    = Home


type alias Model =
    { view : View
    , name : String
    , lawCentre : LawCentre
    , role : Role
    , lawArea : LawArea
    , qualForm : QualForm
    , quantForm : QuantForm
    , weeklyCount : Maybe Int
    , commentFilter : CommentType
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
    , lawCentre : LawCentre
    , commentBody : String
    , likes : Int
    , commentType : CommentType
    , lawArea : LawArea
    }


type alias QuantForm =
    { name : String
    , lawCentre : LawCentre
    , lawArea : LawArea
    , peopleSeenWeekly : Int
    , peopleTurnedAwayWeekly : Int
    }


type Msg
    = NoOp
    | UrlChange Navigation.Location
