module State exposing (..)

import Dom.Scroll exposing (..)
import Ports exposing (..)
import Router exposing (getRoute)
import Task
import Time exposing (Time, second)
import Types exposing (..)
import Commands exposing (..)
import Helpers exposing (..)


initForm : Form
initForm =
    Form "" "" "" "" "" "" "" "" 0 0 "" "" "" "" "" "" "" ""


initModel : Model
initModel =
    { route = Home
    , videoStage = StagePreRecord
    , audioStage = StagePreRecord
    , liveVideoUrl = ""
    , messageLength = 0
    , paused = True
    , videoModal = False
    , audioModal = False
    , recordedVideoUrl = ""
    , airtableForm = initForm
    , formSent = NotSent
    , formRequestCount = 0
    }



-- TODO what is messageLength?


createNewForm : Form -> FormField -> String -> Form
createNewForm currentForm fieldType content =
    case fieldType of
        Name ->
            { currentForm | name = content }

        ContactNumber ->
            { currentForm | contactNumber = content }

        Email ->
            { currentForm | email = content }

        Role ->
            { currentForm | role = content }

        RoleOther ->
            { currentForm | roleOther = content }

        StartDate ->
            { currentForm | startDate = content }

        ContractLength ->
            { currentForm | contractLength = content }

        ContractOther ->
            { currentForm | contractOther = content }

        MinRate ->
            { currentForm
                | minRate = Result.withDefault 0 (String.toInt content)
            }

        MaxRate ->
            { currentForm
                | maxRate = Result.withDefault 0 (String.toInt content)
            }

        CV ->
            { currentForm | cv = content }

        LinkedIn ->
            { currentForm | linkedIn = content }

        Twitter ->
            { currentForm | twitter = content }

        GitHub ->
            { currentForm | gitHub = content }

        Website ->
            { currentForm | website = content }

        Q1 ->
            { currentForm | q1 = content }

        Q2 ->
            { currentForm | q2 = content }

        Q3 ->
            { currentForm | q3 = content }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateForm fieldType content ->
            let
                newForm =
                    createNewForm model.airtableForm fieldType content
            in
                ( { model | airtableForm = newForm }, Cmd.none )

        Increment ->
            if model.messageLength >= 30 then
                model
                    |> update (ToggleVideo StageRecording)
            else
                ( { model | messageLength = model.messageLength + 1 }, Cmd.none )

        RecordStart ->
            ( model, recordStart () )

        RecordStop ->
            ( model, recordStop () )

        ReceiveRecordedVideoUrl string ->
            ( { model | recordedVideoUrl = string, liveVideoUrl = "" }, Cmd.none )

        RecieveQ1Url string ->
            let
                newForm =
                    createNewForm model.airtableForm Q1 string
            in
                ( { model | airtableForm = newForm }, Cmd.none )

        RecieveQ2Url string ->
            let
                newForm =
                    createNewForm model.airtableForm Q2 string
            in
                ( { model | airtableForm = newForm }, Cmd.none )

        RecieveQ3Url string ->
            let
                newForm =
                    createNewForm model.airtableForm Q3 string

                newModel =
                    { model | airtableForm = newForm, formSent = Pending }
            in
                newModel ! [ sendFormCmd model ]

        ReceiveLiveVideoUrl string ->
            ( { model | liveVideoUrl = string, recordedVideoUrl = "" }, Cmd.none )

        RecordError err ->
            ( { model | videoStage = StageRecordError }, Cmd.none )

        UploadQuestion string ->
            ( { model | videoModal = ifThenElse (model.route == ChallengingProject) True False, route = goToNextQuestion model.route }, uploadVideo string )

        UrlChange location ->
            if getRoute location.hash == Home then
                initModel ! []
            else
                ( { model | route = getRoute location.hash }, Task.attempt (always NoOp) (toTop "container") )

        SendForm ->
            ( { model | formSent = Pending }, sendFormCmd model )

        OnFormSent (Ok result) ->
            case result.success of
                True ->
                    ( { model
                        | airtableForm = initForm
                        , formSent = Success
                        , route = ThankYou
                      }
                    , Cmd.none
                    )

                False ->
                    ( { model | formSent = FailureServer }, Cmd.none )

        OnFormSent (Err _) ->
            ( { model | formSent = FailureServer }, Cmd.none )

        ToggleVideo stage ->
            case stage of
                StageRecordError ->
                    ( { model | videoStage = StageRecordError }, Cmd.none )

                StageRecordStopped ->
                    ( { model | videoStage = StagePreRecord, videoModal = True }, prepareVideo () )

                StageRecording ->
                    ( { model | videoStage = StageRecordStopped }, recordStop () )

                StagePreRecord ->
                    ( { model | videoStage = StageRecording }, recordStart () )

        ToggleAudio stage ->
            case stage of
                StageRecordError ->
                    ( { model | audioStage = StageRecordError }, Cmd.none )

                StageRecordStopped ->
                    ( { model | audioStage = StagePreRecord }, prepareVideo () )

                StageRecording ->
                    ( { model | audioStage = StageRecordStopped }, recordStop () )

                StagePreRecord ->
                    ( { model | audioStage = StageRecording }, recordStart () )

        PrepareVideo ->
            { model | videoModal = True, videoStage = StagePreRecord, recordedVideoUrl = "" } ! [ prepareVideo () ]

        PrepareAudio ->
            { model | audioModal = True } ! [ prepareAudio () ]

        NoOp ->
            ( model, Cmd.none )


goToNextQuestion : Route -> Route
goToNextQuestion route =
    case route of
        NextRole ->
            PersonalIntro

        PersonalIntro ->
            ChallengingProject

        ChallengingProject ->
            ChallengingProject

        _ ->
            NextRole


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ recordedVideoUrl ReceiveRecordedVideoUrl
        , getQ1Url RecieveQ1Url
        , getQ2Url RecieveQ2Url
        , getQ3Url RecieveQ3Url
        , recordError RecordError
        , ifThenElse (not model.paused) (Time.every second (always Increment)) Sub.none
        , liveVideoUrl ReceiveLiveVideoUrl
        ]
