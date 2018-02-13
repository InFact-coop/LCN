module Main exposing (..)

import Navigation


-- My Elm Files

import State exposing (..)
import Router exposing (..)
import Types exposing (..)


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = always ( initModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
