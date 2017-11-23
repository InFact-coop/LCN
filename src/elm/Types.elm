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
    , successInput : String
    , bugInput : String
    , helpInput : String
    , suggestInput : String
    , stories : List Story
    }


type alias Story =
    { storyType : FormView
    , body : String
    , votes : Int
    , areaOfCare : AreaOfCare
    }


type FormView
    = Dashboard
    | Success
    | Bug
    | Help
    | Suggest
    | Overview
    | ViewStories (Maybe FormView)
    | AreaOfCare


type AreaOfCare
    = Housing
    | Benefit
    | Misc


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
