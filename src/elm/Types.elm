module Types exposing (..)

import Navigation


-- Model


type Route
    = HomeRoute
    | WorkerView
    | PageTwoRoute


type alias Model =
    { route : Route
    , areaOfCare : Maybe AreaOfCare
    , formView : FormView
    , successInput : Story
    , bugInput : Story
    , helpInput : Story
    , suggestInput : Story
    , stories : List Story
    }


type alias Story =
    { storyType : FormView
    , title : String
    , body : String
    , isPublic : Bool
    , votes : Int
    , areaOfCare : Maybe AreaOfCare
    }


type FormView
    = Dashboard
    | Success
    | Bug
    | Help
    | Suggest
    | Overview
    | ViewStories


type AreaOfCare
    = Housing
    | Benefit
    | Misc


type alias BuildFormInputs =
    { heading : String
    , question : String
    , titleUpdateMsg : String -> Msg
    , bodyUpdateMsg : String -> Msg
    , modelTitleValue : String
    , modelBodyValue : String
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
      --
      -- Aisha's changes
    | UpdateFormView FormView
      -- Mavis' changes
    | UpdateAllStories (List Story)
    | ChangeFormView FormView
