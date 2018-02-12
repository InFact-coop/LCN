module Components.Navbar exposing (..)

import Components.Styles exposing (..)
import Components.Translators exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


navbar : Model -> Html Msg
navbar model =
    let
        bgColour =
            colourPicker model.formView

        linkText =
            getTitle model.formView
    in
    case model.route of
        WorkerViewRoute ->
            nav [ class ("flex justify-between white " ++ bgColour) ]
                [ -- Home link
                  div [ class "flex-grow pa3 flex items-center" ]
                    navbarMsgContent

                -- Name of current page
                , div
                    [ class "flex-grow pa3 flex items-center" ]
                    [ div [ class "f3 white b mr4" ] [ text linkText ] ]
                ]

        _ ->
            ul [] []


navBarLinkStyle : String
navBarLinkStyle =
    "list dib pa3 link dim white b f4 pointer"



-- set up Navigation links here:


navbarLink : ( String, String ) -> Html Msg
navbarLink ( linkStr, name ) =
    div [ class navBarLinkStyle ] [ a [ class "link dim white b", href ("/#" ++ linkStr) ] [ text name ] ]



-- set up our own form change links here:


navbarMsgContent : List (Html Msg)
navbarMsgContent =
    List.map navbarMsg [ ( "Home", AreaOfCare ), ( "Dashboard", Actions ), ( "Made My Day", MadeMyDay ), ( "Bug Bear", Bug ), ( "I-Spy", ISpy ), ( "Snapshot", Snapshot ) ]



-- set up each individual link:


navbarMsg : ( String, FormView ) -> Html Msg
navbarMsg ( name, newView ) =
    li [ class navBarLinkStyle, onClick <| UpdateFormView newView ] [ text name ]
