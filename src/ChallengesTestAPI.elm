module ChallengesTestAPI exposing (viewAPI)

import Messages exposing (..)
import Model exposing (init, Model)
import Html exposing (Html, text, div, img, button)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)


viewAPI : Model -> Html Msg
viewAPI model =
    div [ class "container-challenges" ]
        [ text "Test API Page"
        , div
            [ class "content-API" ]
            [ img [ src model.gifUrl ] []
            , button [ onClick LoadAPIGif ] [ text "load Random Gif" ]
            , displayWeather model
            , button [ onClick LoadAPIWeather ] [ text "load Weather" ]
            ]
        ]



-- Content --


displayWeather : Model -> Html msg
displayWeather model =
    div []
        [ div []
            [ text "Temperature of the day: "
            , text (toString model.weatherTemp)
            ]
        , div []
            [ text "Weather: "
            , text model.weather
            ]
        ]
