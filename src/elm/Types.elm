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

    --, suggestInput : String
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



--
-- Aisha's changes
--
-- Mavis' changes
-- Update


type Msg
    = UrlChange Navigation.Location
    | ChangeSuccessHeading String
    | ChangeSuccessBody String
    | ChangeBugHeading String
    | ChangeBugBody String
    | ChangeHelpHeading String
    | ChangeHelpBody String
    | ChangeSuggestHeading String
    | ChangeSuggestBody String
    | UpdateStories Story
    | IncVote Story
      --
      -- Aisha's changes
    | UpdateFormView FormView
      -- Mavis' changes
    | UpdateAllStories (List Story)
    | ChangeFormView FormView
    | AddStory FormView
    | ChangeAreaOfCareAndView AreaOfCare
    | ChangeBody FormView String
