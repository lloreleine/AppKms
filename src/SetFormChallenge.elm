module SetFormChallenge exposing (setFormChallenge)

import Messages exposing (..)
import Model exposing (init, Model)
import Types exposing (..)
import Html exposing (Html, text, div, input, button, select, option, span)
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
            [ text "Choose the participants: "
            , displayListCommunity model
            ]
        , div []
            [ button
                [ disabled (String.isEmpty model.newChallengeName)
                , type_ "submit"
                , onClick AddChallenge
                ]
                [ text "Add Challenge" ]
            ]
        ]


displayListCommunity : Model -> Html Msg
displayListCommunity model =
    div [ class "selection-newChallenge-participants" ]
        [ div [ class "list-select-from-community" ]
            (List.map
                (\participant ->
                    span
                        [ class "challenge-participant"
                        , onClick (SelectParticipant participant)
                        ]
                        [ text ("- " ++ participant.name) ]
                )
                model.community
            )
        , div [ class "arrow-selection-participants" ] [ text ">" ]
        , div [ class "list-selected-participants" ]
            (List.map
                (\participant ->
                    span
                        [ onClick (DeleteParticipant participant) ]
                        [ text participant.name ]
                )
                model.newChallengeParticipants
            )
        ]
