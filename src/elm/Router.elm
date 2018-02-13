module Router exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Routes.AboutYou exposing (..)
import Routes.ChallengingProject exposing (..)
import Routes.FourOhFour exposing (..)
import Routes.Home exposing (..)
import Routes.NextRole exposing (..)
import Routes.PersonalIntro exposing (..)
import Routes.SubmitScreen exposing (submitScreen)
import Routes.ThankYou exposing (..)
import Types exposing (..)


view : Model -> Html Msg
view model =
    let
        page =
            case model.route of
                Home ->
                    home model

                AboutYou ->
                    aboutYou model

                FourOhFour ->
                    fourohfour model

                NextRole ->
                    nextRole model

                ThankYou ->
                    thankYou model

                PersonalIntro ->
                    personalIntro model

                ChallengingProject ->
                    challengingProject model

                SubmitScreen ->
                    submitScreen model
    in
        div [ class "w-100 fixed overflow-y-scroll top-0 bottom-0 bg-light-blue m0-auto cover", id "container" ]
            [ page
            ]


getRoute : String -> Route
getRoute hash =
    case hash of
        "#home" ->
            Home

        "#about-you" ->
            AboutYou

        "#next-role" ->
            NextRole

        "#thank-you" ->
            ThankYou

        "#personal-intro" ->
            PersonalIntro

        "#challenging-project" ->
            ChallengingProject

        "#submit-screen" ->
            SubmitScreen

        _ ->
            FourOhFour
