module Update exposing (..)

import Model exposing (Model)
import Messages exposing (Msg(SaveName, Register, GoToHome, GoToDashboard, GoToObjectives, GoToChallenges, Logout, DisplayForm, SaveNewObjectiveName, SaveNewObjectiveKms, AddObjective, DeleteOwnObjective))


---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaveName name ->
            ( { model | current = name }, Cmd.none )

        Register ->
            ( { model
                | username = model.current
                , connected = True
              }
            , Cmd.none
            )

        GoToHome ->
            ( { model
                | home = True
                , dashboard = False
                , objectives = False
                , challenges = False
              }
            , Cmd.none
            )

        GoToDashboard ->
            ( { model
                | dashboard = True
                , home = False
                , objectives = False
                , challenges = False
              }
            , Cmd.none
            )

        GoToObjectives ->
            ( { model
                | objectives = True
                , home = False
                , dashboard = False
                , challenges = False
              }
            , Cmd.none
            )

        GoToChallenges ->
            ( { model
                | challenges = True
                , home = False
                , dashboard = False
                , objectives = False
              }
            , Cmd.none
            )

        Logout ->
            ( { model
                | connected = False
                , current = ""
                , username = ""
                , home = True
                , dashboard = False
              }
            , Cmd.none
            )

        DisplayForm ->
            ( { model | setObjForm = True }, Cmd.none )

        SaveNewObjectiveName name ->
            ( { model | newObjName = name }, Cmd.none )

        SaveNewObjectiveKms kms ->
            ( { model | newObjKms = kms }, Cmd.none )

        AddObjective ->
            let
                newKms =
                    Result.withDefault 0 (String.toFloat model.newObjKms)
            in
                ( { model
                    | destinations =
                        { name = model.newObjName
                        , kms = newKms
                        , percent = round (model.kmsAchieved * 100 / newKms)
                        , filling = round (model.kmsAchieved * 300 / newKms)
                        , own = True
                        }
                            :: model.destinations
                    , newObjName = ""
                    , newObjKms = ""
                  }
                , Cmd.none
                )

        DeleteOwnObjective destinationName ->
            let
                cleanListDestinations =
                    List.filter (\dest -> dest.name /= destinationName) model.destinations
                        |> Debug.log "clean destinations"
            in
                ( { model | destinations = cleanListDestinations }, Cmd.none )
