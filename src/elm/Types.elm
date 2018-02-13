module Types exposing (..)

import Navigation
import Http exposing (..)


-- Model


type Route
    = Home
    | AboutYou
    | FourOhFour
    | NextRole
    | ThankYou
    | PersonalIntro
    | ChallengingProject
    | SubmitScreen


type alias Model =
    { route : Route
    , videoStage : Stage
    , audioStage : Stage
    , liveVideoUrl : String
    , recordedVideoUrl : String
    , messageLength : Int
    , paused : Bool
    , videoModal : Bool
    , audioModal : Bool
    , airtableForm : Form
    , formSent : FormState
    , formRequestCount : Int
    }


type FormState
    = NotSent
    | Pending
    | Failure
    | FailureServer
    | Success


type alias Form =
    { name : String
    , contactNumber : String
    , email : String
    , role : String
    , roleOther : String
    , startDate : String
    , contractLength : String
    , contractOther : String
    , minRate : Int
    , maxRate : Int
    , cv : String
    , linkedIn : String
    , twitter : String
    , gitHub : String
    , website : String
    , q1 : String
    , q2 : String
    , q3 : String
    }


type alias FormResponse =
    { success : Bool
    }


type FormField
    = Name
    | ContactNumber
    | Email
    | Role
    | RoleOther
    | StartDate
    | ContractLength
    | ContractOther
    | MinRate
    | MaxRate
    | CV
    | LinkedIn
    | Twitter
    | GitHub
    | Website
    | Q1
    | Q2
    | Q3


type Stage
    = StagePreRecord
    | StageRecording
    | StageRecordStopped
    | StageRecordError



-- Update


type Msg
    = NoOp
    | UrlChange Navigation.Location
    | RecordStart
    | RecordStop
    | RecieveQ1Url String
    | RecieveQ2Url String
    | RecieveQ3Url String
    | UploadQuestion String
    | RecordError String
    | ReceiveRecordedVideoUrl String
    | ReceiveLiveVideoUrl String
    | OnFormSent (Result Http.Error FormResponse)
    | ToggleVideo Stage
    | ToggleAudio Stage
    | Increment
    | PrepareVideo
    | PrepareAudio
    | SendForm
    | UpdateForm FormField String
