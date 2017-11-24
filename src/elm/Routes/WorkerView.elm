module Routes.WorkerView exposing (..)

import Components.Actions exposing (..)
import Components.AreaOfCare exposing (..)
import Components.Navbar exposing (..)
import Components.Styles exposing (..)
import Components.Translators exposing (..)
import Components.ViewStories exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


workerView : Model -> Html Msg
workerView model =
    let
        inputChanger =
            ChangeBody model.formView

        currentView =
            case model.formView of
                MadeMyDay ->
                    buildForm <| BuildFormInputs "Made My Day!" "What's your story?" inputChanger model.madeMyDayInput model.formView

                Bug ->
                    buildForm <| BuildFormInputs "Bug bear!" "What's your bug bear of the week" inputChanger model.bugInput model.formView

                ISpy ->
                    buildForm <| BuildFormInputs "I've noticed..." "What have you noticed happening?" inputChanger model.iSpyInput model.formView

                Snapshot ->
                    div [ class "flex justify-center" ]
                        [ img [ src "./assets/svg/snapshotBackground.svg" ] [] ]

                ViewStories (Just typeFilter) ->
                    viewStoriesPage model typeFilter

                AreaOfCare ->
                    areaOfCarePage model

                Actions ->
                    actionsPage model

                _ ->
                    h1 [] [ text "404 Not Found" ]
    in
    div []
        [ navbar model
        , div [] [ currentView ]
        ]



-- ADD SOMETHING FORM


buildForm : BuildFormInputs -> Html Msg
buildForm formInput =
    let
        lightColour =
            lightColourPicker formInput.formType

        darkColour =
            colourPicker formInput.formType
    in
    div [ class "pt5" ]
        [ div [ class "" ]
            [ div [ class "center pl4 mw8" ]
                [ div [ class (tabStyle ++ lightColour) ] [ text ("Your own " ++ formInput.heading) ]
                , div [ class (tabStyle ++ darkColour), onClick <| UpdateFormView <| ViewStories (Just formInput.formType) ] [ text "View what others think" ]
                ]
            , div [ class ("br3 w-100 mw8 h-ta pa4 center" ++ lightColour) ] [ textarea [ class "f4 w30 pa3 center db br3 bn h-100 w-100 input-reset", onInput formInput.bodyUpdateMsg, value formInput.modelBodyValue, placeholder formInput.question ] [] ]
            ]
        , div [ class "pa3 tc" ] [ div [ class ("f4 pointer link grow br-pill ph4 pv3 shadow-3 mb2 dib white" ++ darkColour), onClick <| AddStory formInput.formType ] [ text "Submit" ] ]
        ]
