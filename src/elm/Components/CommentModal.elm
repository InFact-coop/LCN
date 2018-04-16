module Components.CommentModal exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Components.StyleHelpers exposing (displayElement, classes)
import Components.Button exposing (modalButton)
import Types exposing (..)


commentModal : Model -> Html Msg
commentModal model =
    let
        name =
            if model.name /= "" then
                ", " ++ model.name
            else
                ""
    in
        section
            [ classes
                [ "modal fixed f3 ph5 pb4 pt5 bg-white br2 w-70 z-3 center tc"
                , displayElement model.displayCommentModal
                ]
            ]
            [ img [ src "assets/tick.svg", classes [ "icon-above h4 w4 absolute" ], alt "Success" ] []
            , section [ classes [ "success" ] ]
                [ h1 [ classes [ "f2", "mb4", "mt3" ] ] [ text <| "Thank you" ++ name ++ "!" ]
                , h1 [ classes [ "f2" ] ] [ text "What would you like to do now?" ]
                , section
                    [ classes [ "action-buttons", "mt3" ] ]
                    [ modalButton "See comments" "#list-comments"
                    , modalButton "Add another comment" "#add-comment"
                    , modalButton "Log out" "#logout"
                    ]
                ]
            ]
