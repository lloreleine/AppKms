module Challenges exposing (viewChallenges)

import Messages exposing (..)
import Model exposing (init, Model)
import Types exposing (..)
import SetFormChallenge exposing (setFormChallenge)
import Html exposing (Html, text, div, img, button, h3, h5, span, i, input)
import Html.Attributes exposing (src, height, width, class, disabled, value, type_, property)
import Html.Events exposing (onClick, onInput)
import Json.Encode exposing (string)


viewChallenges : Model -> Html Msg
viewChallenges model =
    div [ class "container-challenges" ]
        [ text "Challenges Page"
        , displayTitle model.user.name
        , displayChallenges model
        ]



-- Title of the page --


displayTitle : String -> Html msg
displayTitle name =
    div [ class "subtitle-challenges" ]
        [ text ("Challenges of the month! Be ready, " ++ name ++ "!") ]



-- Content --


displayChallenges : Model -> Html Msg
displayChallenges model =
    let
        challengeCard =
            model.displayChallengesCard
    in
        if challengeCard.name == "" then
            div [ class "challenges-list" ]
                [ displayChallengesList model
                , button [ class "btn-add-challenge", onClick DisplayChallengeForm ] [ text " + " ]
                , if model.setChallengeForm then
                    setFormChallenge model
                  else
                    div [] []
                ]
        else
            displayChallenge challengeCard



-- Display Challenges LIST --


displayChallengesList : Model -> Html Msg
displayChallengesList model =
    div [ class "cards" ]
        (List.map
            (\challenge ->
                div
                    [ class "card-challenge"
                    , onClick (DisplayChallengeCard challenge)
                    ]
                    [ h3 [] [ text challenge.name ]
                    , div [] [ text ("- " ++ toString challenge.kms ++ " kms -") ]
                    , h5 [] [ text "Participants: " ]
                    , displayParticipants challenge
                    , if challenge.own then
                        button
                            [ class "btn-delete-own-challenge"
                            , onClick (DeleteOwnChallenge challenge.name)
                            ]
                            [ text "X" ]
                      else
                        div [] []
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
                        div [ class "participant-challenge" ]
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
            [ span [ property "innerHTML" (string " &#9659; ") ] []
            , text (toString percent ++ "%")
            ]



-- Display SINGLE Challenge Card --


displayChallenge : Challenge -> Html Msg
displayChallenge challengeCard =
    div
        []
        [ div
            [ class "go-back-challengesList"
            , onClick DiscardChallengeCard
            ]
            [ span [ property "innerHTML" (string " &#9664; ") ] []
            , div [] [ text "Go back" ]
            ]
        , div
            [ class "card-challenge-deployed" ]
            [ h3 [] [ text challengeCard.name ]
            , div [] [ text ("- " ++ toString challengeCard.kms ++ " kms -") ]
            , div [ class "challenge-deployed-subtitle" ] [ text "Well done, all!" ]
            , displayMap challengeCard
            , div
                [ class "card-deployed-participants" ]
                [ displayParticipantsPodium challengeCard ]
            , if challengeCard.own then
                button
                    [ class "btn-delete-own-challenge"
                    , onClick (DeleteOwnChallenge challengeCard.name)
                    ]
                    [ text "X" ]
              else
                div [] []
            ]
        ]


displayParticipantsPodium : Challenge -> Html msg
displayParticipantsPodium challenge =
    let
        orderedListParticipants =
            List.sortWith (\t1 t2 -> compare (.kms t2) (.kms t1)) challenge.participants
    in
        div []
            [ div [ class "podium-participants" ]
                (List.map
                    (\participant ->
                        div [ class "participant-challenge" ]
                            [ div []
                                [ text participant.name
                                , displayPercent participant challenge
                                ]
                            ]
                    )
                    orderedListParticipants
                )
            ]


displayMap : Challenge -> Html msg
displayMap challengeCard =
    img [ src "trip-map-sample.gif", height 200, width 250 ] []
