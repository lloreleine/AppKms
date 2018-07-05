module Messages exposing (..)


type Msg
    = SaveName String
    | Register
    | GoToHome
    | GoToDashboard
    | GoToObjectives
    | GoToChallenges
    | Logout
    | DisplayForm
    | SaveNewObjectiveName String
    | SaveNewObjectiveKms String
    | AddObjective
    | DeleteOwnObjective String
