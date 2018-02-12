module Components.Actions exposing (..)

import Components.Navbar exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


actionsPage : Model -> Html Msg
actionsPage model =
    div [ class "vh-100" ]
        [ h1 [ class "tc grey-font f3" ]
            [ text "What would you like to do today?" ]
        , div
            [ class "" ]
            [ div
                [ class "flex flex-wrap items-center justify-center pl5 pr5" ]
                [ div [ class "w-50 ma3 max-width grow pointer pa3", onClick <| UpdateFormView Bug ]
                    [ div
                        [ class "tc f6 pointer link  pv2 br--top br4 white pink-background" ]
                        [ img [ class "pa3", src "./assets/svg/bug.svg" ] []
                        ]
                    , div [ class "bg-white" ]
                        [ div [ class "bold grey-font f3 tc pb1 pt2 min-height-title" ]
                            [ text "Bug Bear" ]
                        ]
                    , div [ class "tracked br--bottom br4 min-height-para bg-white grey-font f4 tc pl4 pr4 pt3 pb4" ]
                        [ text "Tell us what has got on your nerves this week" ]
                    ]
                , div [ class "w-50 ma3 max-width grow pointer pa3", onClick <| UpdateFormView MadeMyDay ]
                    [ div
                        [ class "tc f6 pointer link  pv2 white br--top br4 orange-background" ]
                        [ img [ class "pa3", src "./assets/svg/happy.svg" ] []
                        ]
                    , div [ class "bg-white" ]
                        [ div [ class "bold grey-font f3 tc pb1 pt2 min-height-title" ]
                            [ text "Made my Week" ]
                        ]
                    , div [ class "tracked br--bottom br4 min-height-para bg-white grey-font f4 tc pl4 pr4  pt3 pb4" ]
                        [ text "What has made your week? Tell us your story!" ]
                    ]
                ]
            , div [ class "flex flex-wrap items-center justify-center pl5 pr5" ]
                [ div [ class "w-50 ma3 max-width grow pointer pa3", onClick <| UpdateFormView ISpy ]
                    [ div
                        [ class "tc f6 pointer link  pv2 white br--top br4 green-background" ]
                        [ img [ class "pa3", src "./assets/svg/spy.svg" ] []
                        ]
                    , div [ class "bg-white" ]
                        [ div [ class "bold grey-font f3 tc pb1 pt2 min-height-title" ]
                            [ text "I-Spy" ]
                        ]
                    , div [ class "tracked br--bottom br4 min-height-para bg-white grey-font f4 tc pl4 pr4  pt3 pb4" ]
                        [ text "Let us know what trends you've noticed this week." ]
                    ]
                , div [ class "w-50 ma3 max-width grow pointer pa3", onClick <| UpdateFormView Snapshot ]
                    [ div
                        [ class "tc f6 pointer link br--top br4  pv2 white blue-background" ]
                        [ img [ class "pa3", src "./assets/svg/snapshot.svg" ] []
                        ]
                    , div [ class "bg-white" ]
                        [ div [ class "bold grey-font f3 tc pb1 pt2 min-height-title" ]
                            [ text "Snapshot" ]
                        ]
                    , div [ class "tracked br--bottom br4 min-height-para bg-white grey-font f4 tc pl4 pr4 pb4 pt3" ]
                        [ text "Have a look at what's going on nationally!" ]
                    ]
                ]
            ]
        , footer
            [ class "w-100 green-background white f4 pa3 mt5 fixed bottom-0" ]
            [ text "Got a question? Got a request?"
            , span [ class "bold underline" ]
                [ text " Ask us!" ]
            ]
        ]



-- , div [ class " tc f6 pointer link  pv2 mb2 dib white orange-background fl w-30 pa4 ma4", onClick <| UpdateFormView Bug ] [ text "Made my Day" ]
-- , div [ class "tc f6 pointer link  pv2 mb2 dib white green-background fl w-30 pa4 ma4", onClick <| UpdateFormView ISpy ] [ text "I-Spy" ]
-- , div [ class "tc f6 pointer link pv2 mb2 dib white blue-background fl w-30 pa4 ma4", onClick <| UpdateFormView Snapshot ] [ text "Snapshot" ]
--
