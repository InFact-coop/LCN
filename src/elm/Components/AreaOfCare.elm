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
            [ ( Housing, "Housing", "bg-green" )
            , ( Community, "Community", "bg-green" )
            , ( Debt, "Debt", "bg-green" )
            , ( Employment, "Employment", "bg-green" )
            , ( WelfareBenefits, "Welfare Benefits", "bg-green" )
            , ( Immigration, "Immigration", "bg-green" )
            , ( PublicLaw, "Public Law", "bg-green" )
            , ( Family, "Family", "bg-green" )
            , ( MentalHealth, "Mental Health", "bg-green" )
            , ( Crime, "Crime", "bg-green" )
            , ( Education, "Education", "bg-green" )
            , ( Consumer, "Consumer", "bg-green" )
            , ( Management, "Management", "bg-green" )
            , ( Triage, "Reception", "bg-green" )
            ]
    in
    div []
        [ h1 [] [ text "Choose your primary area of care" ]
        , div []
            (areas
                |> List.map eachArea
            )
        ]


eachArea : ( AreaOfCare, String, String ) -> Html Msg
eachArea ( area, formattedName, colour ) =
    div [ class (colour ++ " " ++ "f6 pointer link dim br-pill ph3 pv2 mb2 dib white bg-black"), onClick <| ChangeAreaOfCareAndView <| area ] [ text formattedName ]
