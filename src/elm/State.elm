module State exposing (..)

import Dom.Scroll exposing (..)
import Router exposing (getView, viewFromUrl)
import Task
import Types exposing (..)
import Navigation exposing (..)


initModel : Model
initModel =
    { view = Home
    , name = ""
    , lawCentre = Nothing
    , role = Nothing
    , lawArea = Nothing
    , weeklyCount = Nothing
    , peopleSeenWeekly = 0
    , peopleTurnedAwayWeekly = 0
    , commentBody = ""
    , commentType = Nothing
    , commentFilter = Nothing
    , comments = Nothing
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        model =
            viewFromUrl location initModel
    in
        model ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            { model | view = getView location.hash } ! [ Task.attempt (always NoOp) (toTop "container") ]

        UpdateName username ->
            { model | name = username } ! []

        NoOp ->
            model ! []

        UpdateLawCentre lc ->
            { model | lawCentre = Just lc } ! []
