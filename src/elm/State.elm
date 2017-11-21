module State exposing (..)

import Types exposing (..)


-- MODEL


initModel : Model
initModel =
    { route = HomeRoute
    , areaOfCare = Nothing
    , formView = Just Overview
    , successInput = Story Success "" "" False 0 Nothing
    , bugInput = Story Bug "" "" False 0 Nothing
    , helpInput = Story Help "" "" False 0 Nothing
    , suggestInput = Story Suggest "" "" False 0 Nothing
    , stories = []
    }



--UPDATE


getRoute : String -> Route
getRoute hash =
    case hash of
        "#home" ->
            HomeRoute

        "#workerview" ->
            WorkerView

        "#pagetwo" ->
            PageTwoRoute

        _ ->
            HomeRoute


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeSuccessHeading newHeading ->
            let
                oldSuccess =
                    model.successInput

                newSuccess =
                    { oldSuccess | title = newHeading }
            in
            ( { model | successInput = newSuccess }, Cmd.none )

        ChangeSuccessBody newBody ->
            let
                oldSuccess =
                    model.successInput

                newSuccess =
                    { oldSuccess | body = newBody }
            in
            ( { model | successInput = newSuccess }, Cmd.none )

        UrlChange location ->
            ( { model | route = getRoute location.hash }, Cmd.none )

        --
        -- Aisha's changes
        --
        -- Mavis' changes
        ChangeBugHeading newHeading ->
            let
                oldBug =
                    model.bugInput

                newBug =
                    { oldBug | title = newHeading }
            in
            ( { model | bugInput = newBug }, Cmd.none )

        ChangeBugBody newBody ->
            let
                oldBug =
                    model.bugInput

                newBug =
                    { oldBug | body = newBody }
            in
            ( { model | bugInput = newBug }, Cmd.none )

        ChangeHelpHeading newHeading ->
            let
                oldHelp =
                    model.helpInput

                newHelp =
                    { oldHelp | title = newHeading }
            in
            ( { model | helpInput = newHelp }, Cmd.none )

        ChangeHelpBody newBody ->
            let
                oldHelp =
                    model.helpInput

                newHelp =
                    { oldHelp | body = newBody }
            in
            ( { model | helpInput = newHelp }, Cmd.none )

        ChangeSuggestHeading newHeading ->
            let
                oldSuggest =
                    model.suggestInput

                newSuggest =
                    { oldSuggest | title = newHeading }
            in
            ( { model | suggestInput = newSuggest }, Cmd.none )

        ChangeSuggestBody newBody ->
            let
                oldSuggest =
                    model.suggestInput

                newSuggest =
                    { oldSuggest | body = newBody }
            in
            ( { model | suggestInput = newSuggest }, Cmd.none )

        _ ->
            ( model, Cmd.none )
