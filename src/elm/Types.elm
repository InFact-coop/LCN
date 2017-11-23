module Types exposing (..)

import Navigation


-- Model


type Route
    = HomeRoute
    | WorkerViewRoute
    | RepViewRoute


type alias Model =
    { route : Route
    , areaOfCare : AreaOfCare
    , formView : FormView
    , madeMyDayInput : String
    , bugInput : String
    , iSpyInput : String
    , stories : List Story
    }


type alias Story =
    { storyType : FormView
    , body : String
    , votes : Int
    , areaOfCare : AreaOfCare
    , location : String
    }


type FormView
    = Dashboard
    | MadeMyDay
    | Bug
    | ISpy
    | Snapshot
    | Overview
    | ViewStories (Maybe FormView)
    | AreaOfCare


type AreaOfCare
    = Housing
    | Community
    | Debt
    | Employment
    | WelfareBenefits
    | Immigration
    | PublicLaw
    | Family
    | MentalHealth
    | Crime
    | Education
    | Consumer


type alias BuildFormInputs =
    { heading : String
    , question : String
    , bodyUpdateMsg : String -> Msg
    , modelBodyValue : String
    , formType : FormView
    }


type Msg
    = UrlChange Navigation.Location
    | IncVote Story
    | UpdateFormView FormView
    | UpdateAllStories (List Story)
    | AddStory FormView
    | ChangeAreaOfCareAndView AreaOfCare
    | ChangeBody FormView String
