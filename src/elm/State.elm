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
    , lawArea = Nothing
    , role = Nothing
    , weeklyCount = Nothing
    , commentFilter = Nothing
    , comments = Nothing
    , userCommentBody = ""
    , userCommentType = Nothing
    }


initialQualForm : QualForm
initialQualForm =
    { id = Nothing
    , parentId = Nothing
    , name = ""
    , lawCentre = Nothing
    , lawArea = Nothing
    , commentBody = ""
    , likes = 0
    , commentType = Nothing
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

        NoOp ->
            model ! []

        UpdateCommentType commentType ->
            { model | userCommentType = Just commentType } ! []
