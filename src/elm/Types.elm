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
    , problems : List String
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
    = AvonAndBristol
    | Birmingham
    | Brent
    | Bury
    | CambridgeHouse
    | Camden
    | Bradford
    | Coventry
    | Croydon
    | Cumbria
    | Derbyshire
    | Ealing
    | Gloucester
    | Manchester
    | Hackney
    | HammersmithAndFulham
    | Haringey
    | Harrow
    | Hillingdon
    | IsleOfWight
    | Islington
    | KingstonAndRichmond
    | Kirklees
    | Lambeth
    | NorthernIreland
    | WesternAreaNorthernIreland
    | Luton
    | Merseyside
    | MertonAndSutton
    | Newcastle
    | NorthKensington
    | Nottingham
    | Paddington
    | Plumstead
    | Rochdale
    | Sheffield
    | Southwark
    | Springfield
    | Surrey
    | TowerHamlets
    | Vauxhall
    | Wandsworth
    | Wiltshire
    | NoCentre


type Role
    = CaseWorker
    | Management
    | Triage
    | NoRole


type LawArea
    = NoArea
    | WelfareAndBenefits
    | Employment
    | Debt
    | Housing
    | ImmigrationAndAsylum
    | Family
    | CommunityCare
    | PublicLaw


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
    | ToggleProblem String Bool
