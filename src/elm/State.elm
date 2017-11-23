module State exposing (..)

import Data.Stories exposing (..)
import Types exposing (..)


-- MODEL


initModel : Model
initModel =
    { route = HomeRoute
    , areaOfCare = Misc
    , formView = AreaOfCare
    , successInput = ""
    , bugInput = ""
    , helpInput = ""
    , suggestInput = ""
    , stories = Data.Stories.stories
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
        UrlChange location ->
            ( { model | route = getRoute location.hash }, Cmd.none )

        UpdateFormView newView ->
            ( { model | formView = newView }, Cmd.none )

        ChangeSuccessBody newBody ->
            ( { model | successInput = newBody }, Cmd.none )

        ChangeBugBody newBody ->
            ( { model | bugInput = newBody }, Cmd.none )

        ChangeHelpBody newBody ->
            ( { model | helpInput = newBody }, Cmd.none )

        ChangeSuggestBody newBody ->
            ( { model | suggestInput = newBody }, Cmd.none )

        IncVote story ->
            let
                newStory =
                    { story | votes = story.votes + 1 }

                newStories =
                    (model.stories
                        |> List.filter (\st -> st /= story)
                    )
                        ++ [ newStory ]
            in
            ( { model | stories = newStories }, Cmd.none )

        AddStory formType ->
            let
                value =
                    case formType of
                        Success ->
                            Just model.successInput

                        Bug ->
                            Just model.bugInput

                        Help ->
                            Just model.helpInput

                        Suggest ->
                            Just model.suggestInput

                        _ ->
                            Nothing

                storyToAdd =
                    case value of
                        Just value ->
                            Just (Story formType value 0 model.areaOfCare)

                        Nothing ->
                            Nothing
            in
            case storyToAdd of
                Just story ->
                    ( { model
                        | stories = model.stories ++ [ story ]
                        , successInput = ""
                        , bugInput = ""
                        , helpInput = ""
                        , suggestInput = ""
                        , formView = ViewStories (Just formType)
                      }
                    , Cmd.none
                    )

                Nothing ->
                    ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )
