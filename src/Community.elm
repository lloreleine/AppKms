module Community exposing (viewCommunity)

import Messages exposing (..)
import Model exposing (init, Model)
import Types exposing (..)
import Html exposing (Html, text, div, button, h3, h5, i)
import Html.Attributes exposing (class, src, style)
import Html.Events exposing (onClick)


viewCommunity : Model -> Html Msg
viewCommunity model =
    div [ class "container-community" ]
        [ text "Community Page"
        , displayTitle model.user.name
        , displayCommunity model
        ]



-- Title of the page --


displayTitle : String -> Html msg
displayTitle name =
    div [ class "subtitle-community" ]
        [ text ("Check on your friends, " ++ name ++ ":") ]



-- Content --


displayCommunity : Model -> Html Msg
displayCommunity model =
    div []
        (List.map
            (\user ->
                div
                    [ class "card-user"
                    , if model.openUserCard == user then
                        class "user-card-open"
                      else
                        class ""
                    ]
                    [ div
                        [ class "card-user-name"
                        , onClick (OpenUserCard user)
                        ]
                        [ i [ class "fas fa-user-circle user-icon" ] []
                        , h3 [] [ text user.name ]
                        ]
                    , div [ class "card-user-sticker" ]
                        [ div
                            [ class "sticker-connection"
                            , if user.connected then
                                style [ ( "background-color", "green" ) ]
                              else
                                style [ ( "background-color", "red" ) ]
                            ]
                            []
                        ]
                    , div [ class "card-user-kms" ]
                        [ h5 [ class "title-kms-achieved" ] [ text "Kms achevied: " ]
                        , text (toString user.kms ++ "kms")
                        ]

                    -- hidden part:
                    , div
                        [ class "card-challenges" ]
                        [ text "Challenges in progress: "
                        , displayNumberOfChallenges model user
                        ]
                    , div
                        [ class "card-add-friend" ]
                        [ if (checkFriendship model.user user == Pending) then
                            div
                                [ class "btn-friend" ]
                                [ text "Pending" ]
                          else if (checkFriendship model.user user == Validated) then
                            div
                                [ class "btn-friend" ]
                                [ text "Friend" ]
                          else
                            div
                                [ class "btn-add-friend"
                                , onClick (MsgUserWrapper (AddFriend model.user user))
                                ]
                                [ text "+ Add as friend" ]
                        ]
                    , div
                        [ class "card-status" ]
                        [ if (user.kms < 10) then
                            i [ class "fas fa-bed" ] []
                          else if (user.kms > 200) then
                            i [ class "fas fa-rocket" ] []
                          else if (user.kms > 100) then
                            i [ class "fas fa-plane-departure" ] []
                          else if (user.kms > 30) then
                            i [ class "fas fa-bus-alt" ] []
                          else if (user.kms > 10) then
                            i [ class "fas fa-bicycle" ] []
                          else
                            i [ class "far fa-meh-blank" ] []
                        ]
                    ]
            )
            model.community
        )


displayNumberOfChallenges : Model -> User -> Html msg
displayNumberOfChallenges model user =
    let
        nbChallenge =
            List.map
                (\challenge ->
                    List.map
                        (\participant -> participant.name)
                        challenge.participants
                )
                model.challenges
                |> List.map
                    (\challengeNames ->
                        List.filter (\participant -> user.name == participant) challengeNames
                    )
                |> List.map
                    (\challengeNames ->
                        List.length challengeNames
                    )
                |> List.foldl (\x a -> x + a) 0
    in
        div [ class "sticker-challenges-nb" ]
            [ text (toString nbChallenge) ]


checkFriendship : User -> User -> FriendStatus
checkFriendship userConnected userCommunity =
    let
        check =
            List.filter (\friend -> friend.name == userCommunity.name) userConnected.friends
    in
        if (List.isEmpty check) then
            NoFriendship
        else
            checkStatusFriendship check


checkStatusFriendship : List Friend -> FriendStatus
checkStatusFriendship check =
    let
        mapping =
            List.map (\friend -> friend.status) check
    in
        if (mapping == [ Pending ]) then
            Pending
        else
            Validated
