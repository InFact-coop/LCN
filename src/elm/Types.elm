module Types exposing (..)

import Http
import Navigation
import Time exposing (Time)


type View
    = BeforeYouBegin
    | AddStats
    | Snapshot
    | AddComment
    | ListComments
    | SplashScreen


type alias Model =
    { view : View
    , name : String
    , lawCentre : LawCentre
    , lawArea : LawArea
    , role : Role
    , weeklyCount : Maybe Int
    , peopleSeenWeekly : Maybe Int
    , peopleTurnedAwayWeekly : Maybe Int
    , newCasesWeekly : Maybe Int
    , volunteersTotalWeekly : Maybe Int
    , studentVolunteersWeekly : Maybe Int
    , lawyerVolunteersWeekly : Maybe Int
    , vacanciesWeekly : Int
    , mediaCoverageWeekly : Int
    , signpostedInternallyWeekly : Maybe Int
    , signpostedExternallyWeekly : Maybe Int
    , commentBody : String
    , commentType : CommentType
    , comments : List Comment
    , commentStatus : RemoteData
    , postStatsStatus : RemoteData
    , getUserDetailsStatus : RemoteData
    , postUserDetailsStatus : RemoteData
    , listStatsStatus : RemoteData
    , peopleSeenWeeklyAll : Int
    , displayStatsModal : Bool
    , displayCommentModal : Bool
    , problems : List String
    , agencies : List String
    , submitEnabled : Bool
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


type alias UserDetails =
    { name : String
    , lawCentre : LawCentre
    , lawArea : LawArea
    , role : Role
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
    | UpdateNewCases String
    | UpdateSignpostedInternally String
    | UpdateSignpostedExternally String
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
    | ToggleAgency String Bool
    | PostReply Comment
    | PostNewUserDetails
    | PostUserDetailsStatus (Result Http.Error Bool)
    | GetUserDetailsStatus (Result Http.Error UserDetails)
    | UpdateVolunteersTotalWeekly String
    | UpdateStudentVolunteersWeekly String
    | UpdateLawyerVolunteersWeekly String
    | UpdateVacanciesWeekly String
    | UpdateMediaCoverageWeekly String
