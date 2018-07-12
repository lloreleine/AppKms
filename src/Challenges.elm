module Challenges exposing (viewChallenges)

import Messages exposing (..)
import Model exposing (init, Model)
import Types exposing (..)
import SetFormChallenge exposing (setFormChallenge)
import Html exposing (Html, text, div, img, button, h3, h5, span, i, input)
import Html.Attributes exposing (src, class, disabled, value, type_)
import Html.Events exposing (onClick, onInput)


viewChallenges : Model -> Html Msg
viewChallenges model =
    div [ class "container-challenges" ]
        [ text "Challenges Page"
        , displayTitle model.user.name
        , displayChallenges model
        , button [ class "btn-add-challenge", onClick DisplayChallengeForm ] [ text " + " ]
        , if model.setChallengeForm then
            setFormChallenge model
          else
            div [] []
        ]



-- Title of the page --


displayTitle : String -> Html msg
displayTitle name =
    div [ class "subtitle-challenges" ]
        [ text ("Challenges of the month! Be ready, " ++ name ++ "!") ]



-- Content --


displayChallenges : Model -> Html msg
displayChallenges model =
    div [ class "cards" ]
        (List.map
            (\challenge ->
                div [ class "card-challenge" ]
                    [ h3 [] [ text challenge.name ]
                    , div [] [ text ("- " ++ toString challenge.kms ++ " kms -") ]
                    , h5 [] [ text "Participants: " ]
                    , displayParticipants challenge
                    ]
            )
            model.challenges
        )


displayParticipants : Challenge -> Html msg
displayParticipants challenge =
    let
        orderedListParticipants =
            List.sortWith (\t1 t2 -> compare (.kms t2) (.kms t1)) challenge.participants
    in
        div []
            [ div [ class "list-participants" ]
                (List.map
                    (\participant ->
                        div []
                            [ i [ class "fas fa-medal" ] []
                            , text participant.name
                            , displayPercent participant challenge
                            ]
                    )
                    orderedListParticipants
                )
            ]


displayPercent : Participant -> Challenge -> Html msg
displayPercent participant challenge =
    let
        percent =
            round ((participant.kms * 100) / challenge.kms)
    in
        span [ class "percent-participant" ]
            [ text (" - " ++ toString percent ++ "%") ]
