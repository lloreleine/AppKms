module Messages exposing (..)

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
    | GoToTestAPI
    | DisplayForm
    | SaveNewObjectiveName String
    | SaveNewObjectiveKms String
    | AddObjective
    | DeleteOwnObjective String
    | LoadAPIGif
    | NewGif (Result Http.Error String)
    | LoadAPIWeather
    | WeatherTemp (Result Http.Error Float)
    | Weather (Result Http.Error String)
    | AddChallenge
