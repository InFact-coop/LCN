module Types exposing (..)

import Navigation


type View
    = Home


type alias Model =
    { view : View
    }


type Msg
    = NoOp
    | UrlChange Navigation.Location
