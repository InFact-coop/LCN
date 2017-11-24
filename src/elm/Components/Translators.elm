module Components.Translators exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


getTitle : FormView -> String
getTitle formView =
    let
        areaOfCareTitle =
            "Area of Care"

        mmdTitle =
            "Made My Day"

        bugTitle =
            "Bug Bear"

        iSpyTitle =
            "I-Spy"

        snapshotTitle =
            "Snapshot"

        dashboardTitle =
            "Dashboard"
    in
    case formView of
        MadeMyDay ->
            mmdTitle

        Bug ->
            bugTitle

        ISpy ->
            iSpyTitle

        Snapshot ->
            snapshotTitle

        ViewStories (Just formView) ->
            case formView of
                MadeMyDay ->
                    mmdTitle

                Bug ->
                    bugTitle

                ISpy ->
                    iSpyTitle

                Snapshot ->
                    snapshotTitle

                _ ->
                    "Stories"

        AreaOfCare ->
            areaOfCareTitle

        Actions ->
            dashboardTitle

        _ ->
            dashboardTitle



-- set colour


colourPicker : FormView -> String
colourPicker location =
    let
        homeColour =
            " green-background"

        mmdColour =
            " orange-background"

        bugColour =
            " pink-background"

        iSpyColour =
            " green-background"

        snapshotColour =
            " blue-background"
    in
    case location of
        MadeMyDay ->
            mmdColour

        Bug ->
            bugColour

        ISpy ->
            iSpyColour

        Snapshot ->
            snapshotColour

        ViewStories (Just formView) ->
            case formView of
                MadeMyDay ->
                    mmdColour

                Bug ->
                    bugColour

                ISpy ->
                    iSpyColour

                Snapshot ->
                    snapshotColour

                _ ->
                    homeColour

        AreaOfCare ->
            homeColour

        Actions ->
            homeColour

        _ ->
            homeColour


lightColourPicker : FormView -> String
lightColourPicker location =
    let
        mmdColour =
            " light-orange-background"

        bugColour =
            " light-pink-background"

        iSpyColour =
            " light-green-background"

        snapshotColour =
            " light-blue-background"

        homeColour =
            " light-green-background"
    in
    case location of
        MadeMyDay ->
            mmdColour

        Bug ->
            bugColour

        ISpy ->
            iSpyColour

        Snapshot ->
            snapshotColour

        ViewStories (Just formView) ->
            case formView of
                MadeMyDay ->
                    mmdColour

                Bug ->
                    bugColour

                ISpy ->
                    iSpyColour

                Snapshot ->
                    snapshotColour

                _ ->
                    homeColour

        AreaOfCare ->
            homeColour

        Actions ->
            homeColour

        _ ->
            homeColour


getAreas : AreaOfCare -> ( String, String, String )
getAreas areaOfCare =
    let
        areaList =
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

        areaTuple =
            areaList
                |> List.filter (\( area, name, colour, svg ) -> area == areaOfCare)
                |> List.head

        ( area, name, colour, svg ) =
            case areaTuple of
                Just a ->
                    a

                Nothing ->
                    ( Housing, "Housing", "blue-background", "./assets/svg/house.svg" )
    in
    ( name, colour, svg )
