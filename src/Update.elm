module Update exposing (..)

import Model exposing (Model)
import Messages exposing (..)
import Types exposing (..)
import Http
import Json.Decode as Decode exposing (string)


---- UPDATE ----


updateUser : MsgUser -> Model -> User -> User
updateUser msg model user =
    case msg of
        Register ->
            { user
                | name = model.currentName
                , password = model.currentPassword
                , status = "lambda"
                , connected = True
            }

        Logout ->
            { user
                | name = ""
                , password = ""
                , status = ""
                , connected = False
            }

        AddFriend userConnected friend ->
            let
                newFriendsList =
                    List.append userConnected.friends
                        [ { name = friend.name
                          , status = Pending
                          }
                        ]
            in
                { user
                    | friends = newFriendsList
                }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgUserWrapper msgUser ->
            ( { model | user = updateUser msgUser model model.user }
            , Cmd.none
            )

        SaveName name ->
            ( { model | currentName = name }, Cmd.none )

        SavePassword password ->
            ( { model | currentPassword = password }, Cmd.none )

        GoToHome ->
            ( { model
                | homePage = True
                , dashboardPage = False
                , objectivesPage = False
                , challengesPage = False
                , testAPIPage = False
                , communityPage = False
              }
            , Cmd.none
            )

        GoToDashboard ->
            ( { model
                | dashboardPage = True
                , homePage = False
                , objectivesPage = False
                , challengesPage = False
                , testAPIPage = False
                , communityPage = False
              }
            , Cmd.none
            )

        GoToObjectives ->
            ( { model
                | objectivesPage = True
                , homePage = False
                , dashboardPage = False
                , challengesPage = False
                , testAPIPage = False
                , communityPage = False
              }
            , Cmd.none
            )

        GoToChallenges ->
            ( { model
                | challengesPage = True
                , homePage = False
                , dashboardPage = False
                , objectivesPage = False
                , testAPIPage = False
                , communityPage = False
              }
            , Cmd.none
            )

        GoToTestAPI ->
            ( { model
                | testAPIPage = True
                , homePage = False
                , dashboardPage = False
                , objectivesPage = False
                , challengesPage = False
                , communityPage = False
              }
            , Cmd.none
            )

        GoToCommunity ->
            ( { model
                | communityPage = True
                , testAPIPage = False
                , homePage = False
                , dashboardPage = False
                , objectivesPage = False
                , challengesPage = False
              }
            , Cmd.none
            )

        DisplayObjectiveForm ->
            ( { model | setObjForm = True }, Cmd.none )

        SaveNewObjectiveName name ->
            ( { model | newObjName = name }, Cmd.none )

        SaveNewObjectiveKms kms ->
            let
                newIntKms =
                    Result.withDefault 0 (String.toFloat kms)
            in
                ( { model | newObjKms = newIntKms }, Cmd.none )

        AddObjective ->
            ( { model
                | destinations =
                    { name = model.newObjName
                    , kms = model.newObjKms
                    , percent = round (model.kmsAchieved * 100 / model.newObjKms)
                    , filling = round (model.kmsAchieved * 300 / model.newObjKms)
                    , own = True
                    }
                        :: model.destinations
                , newObjName = ""
                , newObjKms = 0.0
                , setObjForm = False
              }
            , Cmd.none
            )

        DeleteOwnObjective destinationName ->
            let
                cleanListDestinations =
                    List.filter (\dest -> dest.name /= destinationName) model.destinations
            in
                ( { model | destinations = cleanListDestinations }, Cmd.none )

        DisplayChallengeForm ->
            ( { model | setChallengeForm = not model.setChallengeForm }, Cmd.none )

        DisplayChallengeCard challenge ->
            ( { model | displayChallengesCard = challenge }, Cmd.none )

        DiscardChallengeCard ->
            ( { model
                | displayChallengesCard =
                    { name = ""
                    , kms = 0.0
                    , participants = []
                    , own = False
                    }
              }
            , Cmd.none
            )

        SaveNewChallengeName name ->
            ( { model | newChallengeName = name }, Cmd.none )

        SaveNewChallengeKms kms ->
            let
                newIntKms =
                    Result.withDefault 0 (String.toFloat kms)
            in
                ( { model | newChallengeKms = newIntKms }, Cmd.none )

        SelectParticipant user ->
            let
                newParticipantsList =
                    List.append model.newChallengeParticipants
                        [ { name = user.name
                          , kms = 0.0
                          }
                        ]
            in
                ( { model | newChallengeParticipants = newParticipantsList }, Cmd.none )

        DeleteParticipant selectedParticipant ->
            let
                cleanParticipantsList =
                    List.filter (\participant -> participant.name /= selectedParticipant.name) model.newChallengeParticipants
            in
                ( { model | newChallengeParticipants = cleanParticipantsList }, Cmd.none )

        AddChallenge ->
            let
                newChallengesList =
                    List.append model.challenges
                        [ { name = model.newChallengeName
                          , kms = model.newChallengeKms
                          , participants = model.newChallengeParticipants
                          , own = True
                          }
                        ]
            in
                ( { model
                    | challenges = newChallengesList
                    , newChallengeName = ""
                    , newChallengeKms = 0.0
                    , newChallengeParticipants = []
                    , setChallengeForm = False
                  }
                , Cmd.none
                )

        DeleteOwnChallenge challengeName ->
            let
                cleanListChallenges =
                    List.filter (\challenge -> challenge.name /= challengeName) model.challenges
            in
                ( { model | challenges = cleanListChallenges }, Cmd.none )

        LoadAPIGif ->
            ( model, fetchGif )

        NewGif (Ok newGif) ->
            ( { model | gifUrl = newGif }, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )

        LoadAPIWeather ->
            ( model, fetchWeatherTemp )

        WeatherTemp (Ok newWeatherTemp) ->
            ( { model | weatherTemp = newWeatherTemp }, Cmd.none )

        WeatherTemp (Err _) ->
            ( model, Cmd.none )

        Weather (Ok newWeather) ->
            ( { model | weather = newWeather }, Cmd.none )

        Weather (Err _) ->
            ( model, Cmd.none )

        OpenUserCard user ->
            if model.openUserCard == user then
                ( { model
                    | openUserCard =
                        { name = ""
                        , password = ""
                        , status = ""
                        , kms = 0.0
                        , connected = False
                        , friends = []
                        }
                  }
                , Cmd.none
                )
            else
                ( { model | openUserCard = user }, Cmd.none )


fetchGif : Cmd Msg
fetchGif =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=cats"
    in
        Http.get url gifDecoder
            |> Http.send NewGif


gifDecoder : Decode.Decoder String
gifDecoder =
    Decode.at [ "data", "image_url" ] Decode.string


urlOpenWeather : String
urlOpenWeather =
    "http://api.openweathermap.org/data/2.5/weather?q=lille&units=metric&APPID="



-- Weather -> weather[0].main // Temperature -> main.temp


fetchWeatherTemp : Cmd Msg
fetchWeatherTemp =
    Http.get urlOpenWeather weatherTempDecoder
        |> Debug.log "weatherTemp "
        |> Http.send WeatherTemp


weatherTempDecoder : Decode.Decoder Float
weatherTempDecoder =
    Decode.at [ "main", "temp" ] Decode.float


fetchWeather : Cmd Msg
fetchWeather =
    Http.get urlOpenWeather weatherDecoder
        |> Debug.log "weather "
        |> Http.send Weather


weatherDecoder : Decode.Decoder String
weatherDecoder =
    Decode.at [ "weather" ] mainWeatherDecoder


mainWeatherDecoder : Decode.Decoder String
mainWeatherDecoder =
    Decode.field "main" Decode.string
