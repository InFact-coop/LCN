module State exposing (..)

import Types exposing (..)


-- MODEL


initModel : Model
initModel =
    { route = HomeRoute
    , areaOfCare = Nothing
    , formView = Success
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
            WorkerViewRoute

        "#repview" ->
            RepViewRoute

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
        UpdateFormView newView ->
            ( { model | formView = newView }, Cmd.none )

        --
        -- Mavis' changes
        _ ->
            ( model, Cmd.none )
