module Types exposing
    ( Comment
    , CommentId
    , CommentType(..)
    , LawArea(..)
    , LawCentre(..)
    , Model
    , Msg(..)
    , RemoteData(..)
    , Role(..)
    , StatsResponse
    , UpvoteResponse
    , UserDetails
    , View(..)
    )

import Http
import Navigation
import Time exposing (Time)


type View
    = BeforeYouBegin
    | AddStats
    | AddComment
    | ListComments
    | SplashScreen
    | About


type alias Model =
    { view : View
    , name : String
    , lawCentre : LawCentre
    , lawArea : LawArea
    , roles : List Role
    , isAdmin : Bool
    , weeklyCount : Int
    , clientMattersWeekly : Int
    , enquiriesWeekly : Int
    , peopleTurnedAwayWeekly : Int
    , newCasesWeekly : Int
    , volunteersTotalWeekly : Int
    , studentVolunteersWeekly : Int
    , lawyerVolunteersWeekly : Int
    , vacanciesWeekly : Int
    , mediaCoverageWeekly : Int
    , signpostedInternallyWeekly : Int
    , signpostedExternallyWeekly : Int
    , internalAppointmentsWeekly : Int
    , commentBody : String
    , commentType : CommentType
    , comments : List Comment
    , postCommentStatus : RemoteData
    , postStatsStatus : RemoteData
    , postUpvoteStatus : RemoteData
    , getUserDetailsStatus : RemoteData
    , postUserDetailsStatus : RemoteData
    , listStatsStatus : RemoteData
    , listCommentsStatus : RemoteData
    , peopleSeenWeeklyAll : Int
    , displayStatsModal : Bool
    , displayCommentModal : Bool
    , problems : List String
    , agencies : List String
    , displayHelpModal : Bool
    , displayHelpInfo : Bool
    }


type alias UpvoteResponse =
    { success : Bool
    , commentId : String
    , commentLikes : Int
    }


type RemoteData
    = NotAsked
    | UserConfirmation
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
    , likedByUser : Bool
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
    , roles : List Role
    , admin : Bool
    }


type Msg
    = NoOp
    | UrlChange Navigation.Location
    | UpdateCommentType CommentType
    | UpdateName String
    | UpdateLawArea LawArea
    | UpdateCommentBody String
    | UpdateClientMatters String
    | UpdateEnquiries String
    | UpdatePeopleTurnedAway String
    | UpdateNewCases String
    | UpdateSignpostedInternally String
    | UpdateSignpostedExternally String
    | UpdateInternalAppointments String
    | UpdateLawCentre LawCentre
    | UpdateRoles Role
    | ReceiveCommentStatus (Result Http.Error Bool)
    | ReceiveUpvoteStatus (Result Http.Error UpvoteResponse)
    | ReceiveStats (Result Http.Error StatsResponse)
    | PostComment
    | PostStats
    | ConfirmStats
    | ToggleStatsModal
    | ReceiveComments (Result Http.Error (List Comment))
    | ToggleReplyComponent Comment
    | ToggleProblem String Bool
    | ToggleAgency String Bool
    | PostReply Comment
    | PostNewUserDetails
    | PostUserDetailsStatus (Result Http.Error Bool)
    | GetUserDetailsStatus (Result Http.Error UserDetails)
    | UpdateStudentVolunteersWeekly String
    | UpdateLawyerVolunteersWeekly String
    | UpdateVacanciesWeekly String
    | UpdateMediaCoverageWeekly String
    | UpvoteComment Comment
    | ChangeView View
    | ToggleHelpInfo
    | ToggleHelpModal
    | GetComments
    | EditStats
