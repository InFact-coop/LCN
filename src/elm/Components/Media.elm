module Components.Media exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


modalText : Stage -> String
modalText stage =
    case stage of
        StagePreRecord ->
            "Click to Record"

        StageRecording ->
            "Click to Stop"

        StageRecordStopped ->
            "Re-record video"

        StageRecordError ->
            "Error!"


videoModal : Model -> Html Msg
videoModal model =
    if model.videoModal then
        div [ class "w-100 h-100 fixed left-0 top-0 modalGray flex items-center justify-center" ]
            [ div [ class "tc" ]
                [ videoTag model
                , button [ class "b white w-30-l w-40-m w-60 bg-gray fw2 center mv4 pa3 br4 fw1 f5 no-underline open-sans", onClick <| ToggleVideo model.videoStage ] [ text <| modalText model.videoStage ]
                , displaySendVideoButton model
                ]
            ]
    else
        div
            [ class "dn" ]
            []


displaySendVideoButton : Model -> Html Msg
displaySendVideoButton model =
    if model.videoStage == StageRecordStopped && model.route == ChallengingProject then
        button [ onClick <| sendQuestion model.route, class "b white w-30-l w-40-m w-60 bg-green fw2 center mv4 pa3 br4 fw1 f5 no-underline open-sans" ] [ text "Confirm and Send" ]
    else if model.videoStage == StageRecordStopped then
        button [ onClick <| sendQuestion model.route, class "b white w-30-l w-40-m w-60 bg-gray fw2 center mv4 pa3 br4 fw1 f5 no-underline open-sans" ] [ text "Confirm Video" ]
    else
        div [] []


sendQuestion : Route -> Msg
sendQuestion route =
    case route of
        NextRole ->
            UploadQuestion "q1"

        PersonalIntro ->
            UploadQuestion "q2"

        ChallengingProject ->
            UploadQuestion "q3"

        _ ->
            NoOp



-- resetVideo : Html Msg
-- resetVideo =
--     button [ onClick PrepareVideo ] [ text "RESET VIDEO" ]


videoTag : Model -> Html Msg
videoTag model =
    if model.liveVideoUrl == "" then
        div [ class "tc" ]
            [ video [ controls True, src model.recordedVideoUrl ] []
            ]
    else
        div [ class "tc" ]
            [ video [ attribute "muted" "true", autoplay True, src model.liveVideoUrl ] []
            ]


audioModal : Model -> Html Msg
audioModal model =
    if model.audioModal then
        div []
            [ button [ class "hite w-30-l w-40-m w-60 bg-gray fw2 center mv4 pa3 br4 fw1 f5 no-underline open-sans", onClick <| ToggleAudio model.audioStage ] [ text "record" ]
            ]
    else
        div [] []
