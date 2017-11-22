module Routes.WorkerView exposing (..)

import Components.Navbar exposing (..)
import Components.ViewStories exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


workerView : Model -> Html Msg
workerView model =
    let
        currentView =
            case model.formView of
                Success ->
                    [ navbar model Success
                    , buildForm <| BuildFormInputs "Success Story!" "What's your story?" ChangeSuccessBody model.successInput Success
                    ]

                Bug ->
                    [ navbar model Bug
                    , buildForm <| BuildFormInputs "Bug bear!" "What's your bug bear of the week" ChangeBugBody model.bugInput Bug
                    ]

                Help ->
                    [ navbar model Help
                    , buildForm <| BuildFormInputs "Help me!" "How can we help?" ChangeHelpBody model.helpInput Help
                    ]

                Suggest ->
                    [ navbar model Suggest
                    , buildForm <| BuildFormInputs "I've got a suggestion" "What's your suggestion?" ChangeSuggestBody model.suggestInput Suggest
                    ]

                ViewStories (Just typeFilter) ->
                    [ viewStoriesPage model typeFilter ]

                _ ->
                    [ navbar model Overview
                    , h1 [] [ text "404 Not Found" ]
                    ]
    in
    div [] currentView


successPage : Model -> Html Msg
successPage model =
    h1 [] [ text "Working" ]



-- ADD SOMETHING FORM


buildForm : BuildFormInputs -> Html Msg
buildForm formInput =
    div []
        [ div []
            [ h1 [ class "tc f1" ] [ text formInput.heading ]
            , p [ class "f3 w60 mh1 tc" ] [ text formInput.question ]
            , textarea [ cols 40, rows 10, class "f3 w30 pa1 center db ba tc", onInput formInput.bodyUpdateMsg, value formInput.modelBodyValue, placeholder "Tell me what you think" ] []
            , div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| AddStory formInput.formType ] [ text "SEND" ]
            ]
        , div []
            [ div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView <| ViewStories (Just formInput.formType) ] [ text "View other stories" ]
            ]
        ]
