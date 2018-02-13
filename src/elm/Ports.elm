port module Ports exposing (..)

import Types exposing (..)


port recordStart : () -> Cmd msg


port recordStop : () -> Cmd msg


port prepareVideo : () -> Cmd msg


port prepareAudio : () -> Cmd msg


port confirmRecording : () -> Cmd msg


port uploadVideo : String -> Cmd msg


port recordError : (String -> msg) -> Sub msg


port recordedVideoUrl : (String -> msg) -> Sub msg


port getQ1Url : (String -> msg) -> Sub msg


port getQ2Url : (String -> msg) -> Sub msg


port getQ3Url : (String -> msg) -> Sub msg


port liveVideoUrl : (String -> msg) -> Sub msg


port audioUrl : (String -> msg) -> Sub msg
