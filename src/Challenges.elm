module Challenges exposing (viewChallenges)

import Messages exposing (..)
import Model exposing (init, Model)
import Html exposing (Html, text, div, img, input, button, form, label)
import Html.Attributes exposing (src, class, type_, value, name)


viewChallenges : Model -> Html Msg
viewChallenges model =
    div [ class "container-challenges" ]
        [ text "Challenges Page"
        , displayTitle model.user.name
        ]



-- Title of the page --


displayTitle : String -> Html msg
displayTitle name =
    div [ class "subtitle-challenges" ]
        [ text ("Challenges of the month! Be ready, " ++ name ++ "!") ]



-- Content --


displayChallenges : Model -> Html Msg
displayChallenges model =
    div [] []
