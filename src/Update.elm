module Update exposing (..)

import Model exposing (Model)
import Messages exposing (Msg(GoToDashboard, GoToChallenges))


---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Messages.SaveName name ->
            ( { model | current = name }, Cmd.none )

        Messages.Register ->
            ( { model
                | username = model.current
                , connected = True
              }
            , Cmd.none
            )

        Messages.GoToHome ->
            ( { model
                | home = True
                , dashboard = False
                , objectives = False
                , challenges = False
              }
            , Cmd.none
            )

        Messages.GoToDashboard ->
            ( { model
                | dashboard = True
                , home = False
                , objectives = False
                , challenges = False
              }
            , Cmd.none
            )

        Messages.GoToObjectives ->
            ( { model
                | objectives = True
                , home = False
                , dashboard = False
                , challenges = False
              }
            , Cmd.none
            )

        Messages.GoToChallenges ->
            ( { model
                | challenges = True
                , home = False
                , dashboard = False
                , objectives = False
              }
            , Cmd.none
            )

        Messages.Logout ->
            ( { model
                | connected = False
                , current = ""
                , username = ""
                , home = True
                , dashboard = False
              }
            , Cmd.none
            )

        Messages.DisplayForm ->
            ( { model | setObjForm = True }, Cmd.none )
