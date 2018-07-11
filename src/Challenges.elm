module Challenges exposing (viewChallenges)

import Messages exposing (..)
import Model exposing (init, Model)
import Html exposing (Html, text, div, img, input, button, form, label)
import Html.Attributes exposing (src, class, type_, value, name)
import Html.Events exposing (onClick)


viewChallenges : Model -> Html Msg
viewChallenges model =
    div [ class "container-challenges" ]
        [ text "Challenges Page"
        , displayTitle model.user.name
        , img [ src model.gifUrl ] []
        , button [ onClick LoadAPIGif ] [ text "load Random Gif" ]
        , displayWeather model
        , button [ onClick LoadAPIWeather ] [ text "load Weather" ]
        ]



-- Title of the page --


displayTitle : String -> Html msg
displayTitle name =
    div [ class "subtitle-challenges" ]
        [ text ("Challenges of the month! Be ready, " ++ name ++ "!") ]



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
