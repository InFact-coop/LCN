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
    , qualForm = initialQualForm
    , quantForm = initialQuantForm
    , weeklyCount = Nothing
    , commentFilter = Nothing
    , comments = Nothing
    }


initialQualForm : QualForm
initialQualForm =
    { id = Nothing
    , parentId = Nothing
    , name = ""
    , lawCentre = Nothing
    , commentBody = ""
    , likes = 0
    , commentType = Nothing
    , lawArea = Nothing
    }


initialQuantForm : QuantForm
initialQuantForm =
    { name = ""
    , lawCentre = Nothing
    , lawArea = Nothing
    , peopleSeenWeekly = 0
    , peopleTurnedAwayWeekly = 0
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
            let
                oldQuantForm =
                    model.quantForm

                oldQualForm =
                    model.qualForm

                newQuantForm =
                    { oldQuantForm | name = username }

                newQualForm =
                    { oldQualForm | name = username }
            in
                { model | name = username, quantForm = newQuantForm, qualForm = newQualForm } ! []

        NoOp ->
            model ! []
