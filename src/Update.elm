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
            in
                ( { model | destinations = cleanListDestinations }, Cmd.none )

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
