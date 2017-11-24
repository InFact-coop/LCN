module Components.AreaOfCare exposing (..)

import Components.Navbar exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


areaOfCarePage : Model -> Html Msg
areaOfCarePage model =
    let
        areas =
            [ ( Housing, "Housing", "blue-background", "./assets/svg/house.svg" )
            , ( WelfareBenefits, "Welfare Benefits", "green-background", "./assets/svg/welfare.svg" )
            , ( Immigration, "Immigration", "pink-background", "./assets/svg/passport.svg" )
            , ( Employment, "Employment/ Discrimination", "orange-background", "./assets/svg/employment.svg" )
            , ( Debt, "Debt", "blue-background", "./assets/svg/debt.svg" )
            , ( Community, "Community Care", "green-background", "./assets/svg/community.svg" )
            , ( Management, "Management", "pink-background", "./assets/svg/management.svg" )
            , ( Triage, "Reception/ Triage", "orange-background", "./assets/svg/triage.svg" )
            , ( PublicLaw, "Public Law", "blue-background", "./assets/svg/public.svg" )
            , ( Family, "Family", "green-background", "./assets/svg/family.svg" )
            , ( MentalHealth, "Mental Health", "pink-background", "./assets/svg/mental.svg" )
            , ( Crime, "Crime", "orange-background", "./assets/svg/crime.svg" )
            , ( Education, "Education", "green-background", "./assets/svg/education.svg" )
            , ( Consumer, "Consumer", "pink-background", "./assets/svg/consumer.svg" )
            ]
    in
    div []
        [ h1 [ class "tc grey-font" ] [ text "Choose your primary area of care" ]
        , div [ class "flex flex-wrap justify-center ml5 mr5 pl5 pr5 " ]
            (areas
                |> List.map eachArea
            )
        ]


eachArea : ( AreaOfCare, String, String, String ) -> Html Msg
eachArea ( area, areaName, colour, svg ) =
    div []
        [ div [ class (colour ++ " " ++ "flex flex-column justify-center grow f4 shadow-2 items-center flex-wrap pointer link tc ml4 mr4 mb4 mt4 square br3 white"), onClick <| ChangeAreaOfCareAndView <| area ]
            [ img [ src svg ] []
            , br []
                []
            , text areaName
            ]
        ]
