module SetFormChallenge exposing (setFormChallenge)

import Messages exposing (..)
import Model exposing (init, Model)
import Html exposing (Html, text, div, input, button)
import Html.Attributes exposing (class, type_, value, disabled)
import Html.Events exposing (onClick, onInput)


setFormChallenge : Model -> Html Msg
setFormChallenge model =
    div
        [ class "form-setChallenge" ]
        [ div []
            [ text "Please, enter the name of your challenge:"
            , input
                [ type_ "text"
                , value model.newChallengeName
                , onInput SaveNewChallengeName
                , class "input-setChallenge"
                ]
                []
            ]
        , div []
            [ text "Please, enter the number of kms:"
            , input
                [ type_ "text"
                , onInput SaveNewChallengeKms
                , class "input-setChallenge"
                ]
                []
            ]
        , div []
            [ text "Choose the participants: " ]
        , div []
            [ button
                [ disabled (String.isEmpty model.newChallengeName)
                , type_ "submit"
                , onClick AddChallenge
                ]
                [ text "Add Challenge" ]
            ]
        ]
