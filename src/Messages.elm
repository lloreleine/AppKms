module Messages exposing (..)


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
