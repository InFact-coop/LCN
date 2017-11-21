module Routes.WorkerView exposing (..)

import Components.Overview exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


workerView : Model -> Html Msg
workerView model =
    let
        currentView =
            case model.formView of
                Just Success ->
                    buildForm <| BuildFormInputs "Success Story!" "What's your story?" ChangeSuccessHeading ChangeSuccessBody model.successInput.title model.successInput.body

                Just Bug ->
                    buildForm <| BuildFormInputs "Bug bear!" "What's your bug bear of the week" ChangeBugHeading ChangeBugBody model.bugInput.title model.bugInput.body

                Just Help ->
                    buildForm <| BuildFormInputs "Help me!" "How can we help?" ChangeHelpHeading ChangeHelpBody model.helpInput.title model.helpInput.body

                Just Suggest ->
                    buildForm <| BuildFormInputs "I've got a suggestion" "What's your suggestion?" ChangeSuggestHeading ChangeSuggestBody model.suggestInput.title model.suggestInput.body

                --
                --             Just Bug ->
                --                 bugPage model
                --             Just Help ->
                --                 helpPage model
                --
                --             Just Suggest ->
                --                 suggestPage model
                --
                Just Overview ->
                    overviewPage model

                --
                --             Just ViewStories ->
                --                 viewStoriesPage model
                --
                --             Nothing ->
                --                 questionsPage model
                _ ->
                    buildForm <| BuildFormInputs "DEFAULT" "Shhhhh" ChangeSuccessHeading ChangeSuccessBody model.successInput.title model.successInput.body
    in
        div [ class "w-60-ns center" ]
            [ currentView
            ]


successPage : Model -> Html Msg
successPage model =
    h1 [] [ text "Working" ]


buildForm : BuildFormInputs -> Html Msg
buildForm formInput =
    div []
        [ h1 [ class "tc f1" ] [ text formInput.heading ]
        , p [ class "f3 w60 mh1 tc" ] [ text formInput.question ]
        , input [ class "f3 w30 pa1 center db ba tc", onInput formInput.titleUpdateMsg, value formInput.modelTitleValue, placeholder "Give me a title" ] []
        , input [ class "f3 w30 pa1 center db ba tc", onInput formInput.bodyUpdateMsg, value formInput.modelBodyValue, placeholder "Tell me what you think" ] []
        ]
