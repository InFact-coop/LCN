module Routes.WorkerView exposing (..)

import Components.Actions exposing (..)
import Components.AreaOfCare exposing (..)
import Components.Navbar exposing (..)
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
                    [ navbar model
                    , buildForm <| BuildFormInputs "Made My Day!" "What's your story?" inputChanger model.madeMyDayInput model.formView
                    ]

                Bug ->
                    [ navbar model
                    , buildForm <| BuildFormInputs "Bug bear!" "What's your bug bear of the week" inputChanger model.bugInput model.formView
                    ]

                ISpy ->
                    [ navbar model
                    , buildForm <| BuildFormInputs "I've noticed..." "What have you noticed happening?" inputChanger model.iSpyInput model.formView
                    ]

                Snapshot ->
                    [ navbar model
                    , div [ class "flex justify-center" ]
                        [ img [ src "./assets/svg/snapshotBackground.svg" ] []
                        ]
                    ]

                ViewStories (Just typeFilter) ->
                    [ navbar model
                    , viewStoriesPage model typeFilter
                    ]

                AreaOfCare ->
                    [ navbar model
                    , areaOfCarePage model
                    ]

                Actions ->
                    [ navbar model
                    , actionsPage model
                    ]

                _ ->
                    [ navbar model
                    , h1 [] [ text "404 Not Found" ]
                    ]
    in
    div [] currentView



-- ADD SOMETHING FORM


buildForm : BuildFormInputs -> Html Msg
buildForm formInput =
    div []
        [ div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView <| Actions ] [ text "Do something else" ]
        , div []
            [ h1 [ class "tc f1" ] [ text formInput.heading ]
            , p [ class "f3 w60 mh1 tc" ] [ text formInput.question ]
            , textarea [ cols 40, rows 10, class "f3 w30 pa1 center db ba tc", onInput formInput.bodyUpdateMsg, value formInput.modelBodyValue, placeholder "Tell us more" ] []
            , div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| AddStory formInput.formType ] [ text "SEND" ]
            ]
        , div []
            [ div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView <| ViewStories (Just formInput.formType) ] [ text "View what others think" ]
            ]
        ]
