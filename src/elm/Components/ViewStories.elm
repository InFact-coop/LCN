module Components.ViewStories exposing (..)

import Components.Navbar exposing (..)
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
    in
    div []
        [ navbar model filter
        , ul []
            (model.stories
                |> List.filter (\story -> story.storyType == filter)
                |> List.sortWith descendingVotes
                |> List.map eachStory
            )
        , div []
            [ div [ class "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black", onClick <| UpdateFormView <| filter ] [ text "Back to your own" ] ]
        ]


eachStory : Story -> Html Msg
eachStory story =
    div [ class "pointer ba", onClick <| IncVote story ]
        [ div [] [ text <| toString story.storyType ]
        , div [] [ text story.body ]
        , div [] [ text <| toString story.areaOfCare ]
        , div [] [ text <| toString story.votes ]
        ]
