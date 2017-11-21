module Components.Overview exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


overviewPage : Model -> Html Msg
overviewPage model =
    let
        inputs =
            [ model.successInput, model.bugInput, model.helpInput, model.suggestInput ]
    in
    div []
        [ ul []
            (inputs
                |> List.map inputList
            )
        , button [ onClick (UpdateAllStories inputs) ] [ text "Submit" ]
        ]


inputList : Story -> Html Msg
inputList newStories =
    li []
        [ h1 []
            [ text (toString newStories.storyType) ]
        , h2
            []
            [ text newStories.title ]
        , p [] [ text newStories.body ]
        ]
