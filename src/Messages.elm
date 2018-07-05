module Messages exposing (..)

import Types exposing (..)
import Http


type MsgUser
    = Register
    | Logout


type Msg
    = MsgUserWrapper MsgUser
    | SaveName String
    | SavePassword String
    | GoToHome
    | GoToDashboard
    | GoToObjectives
    | GoToChallenges
    | DisplayForm
    | SaveNewObjectiveName String
    | SaveNewObjectiveKms String
    | AddObjective
    | DeleteOwnObjective String
    | LoadAPI
    | NewGif (Result Http.Error String)
