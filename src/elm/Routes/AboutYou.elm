module Routes.AboutYou exposing (..)

import Components.GrayButton exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


aboutYou : Model -> Html Msg
aboutYou model =
    section [ class "bg-light-blue m0-auto cover" ]
        [ header []
            [ h1 [ class "tc dark-gray raleway fw2 pa5-ns pa4 f2 m0-auto" ] [ text "Tell us about you" ]
            ]
        , section [ class "w-60-l w-90 w-75-m center bg-white br3 shadow-1 pv3 mb4" ]
            [ article [ class " w-90 center pv1" ]
                [ div []
                    [ img [ src "./assets/about_you.svg", class "absolute minus-margin h3" ] []
                    , div [ class "mid-gray b bb b--light-gray f3 f3 raleway" ] [ text "About you" ]
                    , div [ class "open-sans black fw4 flex justify-between flex-wrap f6" ]
                        [ div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Full Name"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50 ba", onInput <| UpdateForm Name ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Phone Number"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50", onInput <| UpdateForm ContactNumber, pattern "(?:0|\\+?)(?:\\d\\s?){9,12}" ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Email"
                            , div [] [ input [ type_ "email", class "br4 b--moon-gray w-75 h2 mt2 ba o-50", onInput <| UpdateForm Email ] [] ]
                            ]
                        ]
                    ]
                ]
            , article [ class " w-90 center pv1" ]
                [ div []
                    [ img [ src "./assets/job_spec.svg", class "absolute minus-margin h3" ] []
                    , div [ class "mid-gray b bb b--light-gray f3 raleway" ] [ text "What kind of job are you looking for?" ]
                    , div [ class "black f5 pv2 open-sans" ] [ text "Type of job" ]
                    , div [ class "mid-gray fw1 raleway flex flex-row" ]
                        [ div [ class "pr3 f5 pb2 w5" ]
                            [ input [ type_ "radio", class "mr2", name "role", onClick <| UpdateForm Role "Backend", checked True ] []
                            , text "Backend"
                            ]
                        , div [ class " f5 pb2" ]
                            [ input [ type_ "radio", name "role", onClick <| UpdateForm Role "Product Manager" ] []
                            , text "Product Manager"
                            ]
                        ]
                    , div [ class "mid-gray fw1 raleway flex flex-row" ]
                        [ div [ class "pr3 f5 pb2 w5" ]
                            [ input [ type_ "radio", class "mr2", name "role", onClick <| UpdateForm Role "Frontend" ] []
                            , text "Frontend"
                            ]
                        , div [ class " f5 pb2" ]
                            [ input [ type_ "radio", name "role", onClick <| UpdateForm Role "Visual Designer" ] []
                            , text "Visual Designer"
                            ]
                        ]
                    , div [ class "mid-gray fw1 raleway flex flex-row" ]
                        [ div [ class "pr3 f5 pb2 w5" ]
                            [ input [ type_ "radio", class "mr2", name "role", onClick <| UpdateForm Role "Full Stack" ] []
                            , text "Full Stack"
                            ]
                        , div [ class " f5 pb2" ]
                            [ input [ type_ "radio", name "role", onClick <| UpdateForm Role "User Research" ] []
                            , text "User Research"
                            ]
                        ]
                    , div [ class "mid-gray fw1 raleway flex flex-column" ]
                        [ div [ class "pr3 f5 pb2 " ]
                            [ input [ type_ "radio", class "mr2", name "role", onClick <| UpdateForm Role "Other" ] []
                            , text "Any other comments"
                            ]
                        , input [ type_ "text", class "w-20 h2 ba b--moon-gray o-50 br4 pl2", placeholder "If other, please state", name "role", onInput <| UpdateForm RoleOther ] []
                        ]
                    , div [ class "black f5 pv2 open-sans mt3" ] [ text "When would you like your next contract to start?" ]
                    , input [ type_ "date", class "w-20 h2 ba b--moon-gray o-50 br4 pl2", onInput <| UpdateForm StartDate ] []
                    , div [ class "black f5 pv2 open-sans mt3" ] [ text "What is your ideal length of contract?" ]
                    , div [ class "mid-gray fw1 raleway" ]
                        [ div [ class "pr3 f5 pb2" ]
                            [ input [ type_ "radio", class "mr2", name "contract-length", onClick <| UpdateForm ContractLength "1 month", checked True ] []
                            , text "1 month"
                            ]
                        , div [ class "pr3 f5 pb2" ]
                            [ input [ type_ "radio", class "mr2", name "contract-length", onClick <| UpdateForm ContractLength "3 months" ] []
                            , text "3 months"
                            ]
                        , div [ class "pr3 f5 pb2" ]
                            [ input [ type_ "radio", class "mr2", name "contract-length", onClick <| UpdateForm ContractLength "6 months" ] []
                            , text "6 months"
                            ]
                        , div [ class "pr3 f5 pb2" ]
                            [ input [ type_ "radio", class "mr2", name "contract-length", onClick <| UpdateForm ContractLength "1 year" ] []
                            , text "1 year"
                            ]
                        , div [ class "pr3 f5 pb2" ]
                            [ input [ type_ "radio", class "mr2", name "contract-length", onClick <| UpdateForm ContractLength "I'm flexible!" ] []
                            , text "I'm flexible!"
                            ]
                        , div [ class "pr3 f5 pb2" ]
                            [ input [ type_ "radio", class "mr2", name "contract-length", onClick <| UpdateForm ContractLength "other" ] []
                            , text "Any other comments"
                            ]
                        , div [ class "f6 flex flex-column" ]
                            [ input [ type_ "text", class "w-20 br4 ba b--moon-gray h2 pl2 mid-gray mt2", placeholder "Please state", onInput <| UpdateForm ContractOther ] []
                            ]
                        ]
                    , div [ class "black f5 pv2 open-sans mt3 gray" ]
                        [ text "Daily Rate" ]
                    , div
                        [ class "mid-gray mb3" ]
                        [ text "Min:"
                        , input [ type_ "text", class "w-1s0 br4 ba b--moon-gray h2 pl2 mid-gray mt2 mr3", placeholder "£", onInput <| UpdateForm MinRate ] []
                        , text "Max:"
                        , input [ type_ "text", class "w-1s0 br4 ba b--moon-gray h2 pl2 mid-gray mt2", placeholder "£", onInput <| UpdateForm MaxRate ] []
                        ]
                    ]
                ]
            , article [ class " w-90 center pv1" ]
                [ div []
                    [ img [ src "./assets/cv.svg", class "absolute minus-margin h3" ] []
                    , div [ class "mid-gray b bb b--light-gray f3 raleway" ] [ text "Link to your CV" ]
                    , div [ class "open-sans black fw4 flex justify-between flex-wrap f6" ]
                        [ div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Add a link to your CV here"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50", onInput <| UpdateForm CV ] [] ]
                            ]
                        ]
                    ]
                ]
            , article [ class " w-90 center pv1" ]
                [ div []
                    [ img [ src "./assets/social_media.svg", class "absolute minus-margin h3" ] []
                    , div [ class "mid-gray b bb b--light-gray f3 raleway" ] [ text "Add links to your social media accounts" ]
                    , div [ class "open-sans black fw4 flex justify-between flex-wrap f6" ]
                        [ div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "LinkedIn"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50 o-50", onInput <| UpdateForm LinkedIn ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Twitter"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50", onInput <| UpdateForm Twitter ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Github"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50", onInput <| UpdateForm GitHub ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Personal Website"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50", onInput <| UpdateForm Website ] [] ]
                            ]
                        ]
                    ]
                ]
            ]
        , grayButton ( "Next", "next-role" )
        ]
