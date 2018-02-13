module Views.AddComment exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


addCommentView : Model -> Html Msg
addCommentView model =
    div [ class "flex flex-column items-center" ]
        [ div []
            [ summary
            , chooseTopic
            , inputComment
            ]
        ]


summary : Html Msg
summary =
    div []
        [ h1 [] [ text "Summary" ]
        , p [] [ text "An intro to this section could go here. Explaining that it's optional and why the information is useful" ]
        ]


chooseTopic : Html Msg
chooseTopic =
    div []
        [ h1 [] [ text "Choose a topic" ]
        , div []
            (List.map
                (topicButton << commentTypeToString)
                topics
            )
        ]


inputComment : Html Msg
inputComment =
    div [ class "flex flex-column" ]
        [ h1 [] [ text "Tell us about the success you've had" ]
        , textarea [] []
        , button [] [ text "Submit" ]
        ]


topics : List CommentType
topics =
    [ Trend, Success, Annoyance, AboutUs ]


commentTypeToString : CommentType -> String
commentTypeToString commentType =
    case commentType of
        Trend ->
            "Trend"

        Success ->
            "Success"

        Annoyance ->
            "Annoyance"

        AboutUs ->
            "About Us"


topicButton : String -> Html Msg
topicButton name =
    button [] [ text name ]
