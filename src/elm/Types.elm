module Types exposing (..)

import Navigation


type View
    = HomeView
    | QuantFormView
    | SnapshotView
    | QualFormView
    | CommentsView


type alias Model =
    { view : View
    }


type Msg
    = NoOp
    | UrlChange Navigation.Location
