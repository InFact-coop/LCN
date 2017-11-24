module State exposing (..)

import Data.Stories exposing (..)
import Types exposing (..)


-- MODEL


initModel : Model
initModel =
    { route = WorkerViewRoute
    , areaOfCare = Housing
    , formView = AreaOfCare
    , madeMyDayInput = ""
    , bugInput = ""
    , iSpyInput = ""
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

        ChangeBody input newBody ->
            case input of
                MadeMyDay ->
                    ( { model | madeMyDayInput = newBody }, Cmd.none )

                Bug ->
                    ( { model | bugInput = newBody }, Cmd.none )

                ISpy ->
                    ( { model | iSpyInput = newBody }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

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
                        MadeMyDay ->
                            Just model.madeMyDayInput

                        Bug ->
                            Just model.bugInput

                        ISpy ->
                            Just model.iSpyInput

                        _ ->
                            Nothing

                storyToAdd =
                    case value of
                        Just value ->
                            Just (Story formType value 0 model.areaOfCare "Bromley")

                        Nothing ->
                            Nothing
            in
            case storyToAdd of
                Just story ->
                    ( { model
                        | stories = model.stories ++ [ story ]
                        , madeMyDayInput = ""
                        , bugInput = ""
                        , iSpyInput = ""
                        , formView = ViewStories (Just formType)
                      }
                    , Cmd.none
                    )

                Nothing ->
                    ( model, Cmd.none )

        ChangeAreaOfCareAndView newArea ->
            ( { model
                | formView = Questions
                , areaOfCare = newArea
              }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )
