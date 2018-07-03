module Update exposing (..)

import Model exposing (Model)
import Messages exposing (Msg(SaveName, Register, GoToHome, GoToDashboard, GoToObjectives, GoToChallenges, Logout, DisplayForm))


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
