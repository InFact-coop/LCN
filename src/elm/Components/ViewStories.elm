module Components.ViewStories exposing (..)

import Components.Styles exposing (..)
import Components.Translators exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


viewStoriesPage : Model -> FormView -> Html Msg
viewStoriesPage model filter =
    let
        descendingVotes a b =
            case compare a.votes b.votes of
                LT ->
                    GT

                EQ ->
                    EQ

                GT ->
                    LT

        lightColour =
            lightColourPicker model.formView

        darkColour =
            colourPicker model.formView

        linkText =
            getTitle model.formView
    in
    div [ class "pt5" ]
        [ div [ class "" ]
            [ div [ class "center pl4 mw8" ]
                [ div [ class (tabStyle ++ darkColour), onClick <| UpdateFormView <| filter ] [ text ("Your own " ++ linkText) ]
                , div [ class (tabStyle ++ lightColour) ] [ text "View what others think" ]
                ]
            , div [ class ("br3 w-100 mw8 h-ta pa4 center" ++ lightColour) ]
                [ main_
                    [ class "f4 center db br3 bn h-100 w-100 ma0 pa2 overflow-scroll " ]
                    (model.stories
                        |> List.filter (\story -> story.storyType == filter)
                        |> List.sortWith descendingVotes
                        |> List.map eachStory
                    )
                ]
            ]
        ]


eachStory : Story -> Html Msg
eachStory story =
    let
        ( areaName, areaBG, areaSVG ) =
            getAreas story.areaOfCare
    in
    div [ class "dt w-100 bb b--light-gray pa2 ma2 grey-font bw1" ]
        [ div [ class "dtc w5 b v-mid tc" ]
            [ text story.location ]
        , div
            [ class "dtc w3 ma2 pa2 mh1" ]
            [ img [ src areaSVG ] [] ]
        , div [ class "dtc speech-width v-mid" ] [ div [ class "i mh2 bg-white b--black w-100 br3 shadow-3 pa3 f4 h3 v-top" ] [ text story.body ] ]
        , div [ class "dtc tc v-mid" ] [ img [ class "pointer grow tc v-mid w3", src "./assets/png/thumb.png", onClick <| IncVote story ] [] ]
        , div [ class "dtc w5 b center v-mid" ] [ text <| toString story.votes ++ " people agree!" ]
        ]



--let
--    lightColour =
--        lightColourPicker formInput.formType
--    darkColour =
--        colourPicker formInput.formType
--in
