module Messages exposing (..)

import Types exposing (..)
import Http


type MsgUser
    = Register
    | Logout
    | AddFriend User User


type Msg
    = MsgUserWrapper MsgUser
    | SaveName String
    | SavePassword String
    | GoToHome
    | GoToDashboard
    | GoToObjectives
    | GoToChallenges
    | GoToTestAPI
    | GoToCommunity
    | DisplayObjectiveForm
    | SaveNewObjectiveName String
    | SaveNewObjectiveKms String
    | AddObjective
    | DeleteOwnObjective String
    | LoadAPIGif
    | NewGif (Result Http.Error String)
    | LoadAPIWeather
    | WeatherTemp (Result Http.Error Float)
    | Weather (Result Http.Error String)
    | DisplayChallengeForm
    | SaveNewChallengeName String
    | SaveNewChallengeKms String
    | SelectParticipant User
    | DeleteParticipant Participant
    | AddChallenge
    | DeleteOwnChallenge String
    | OpenUserCard User
