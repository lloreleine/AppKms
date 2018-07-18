module Main exposing (..)

import Messages exposing (..)
import Model exposing (init, Model)
import Update exposing (update)
import Home exposing (viewHome)
import Dashboard exposing (viewDash)
import Objectives exposing (viewObjectives)
import Challenges exposing (viewChallenges)
import ChallengesTestAPI exposing (viewAPI)
import Community exposing (viewCommunity)
import Html exposing (Html, text, div, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "global" ]
        [ displayMenu model
        , displayContent model
        ]



-- Menu --


displayMenu : Model -> Html Msg
displayMenu model =
    if (model.user.connected) then
        div [ class "menu" ]
            [ text "Menu"
            , button [ onClick GoToHome ] [ text "Home" ]
            , button [ onClick GoToDashboard ] [ text "Dashboard" ]
            , button [ onClick GoToObjectives ] [ text "Objectives" ]
            , button [ onClick GoToChallenges ] [ text "Challenges" ]
            , button [ onClick GoToTestAPI ] [ text "Tests API" ]
            , button [ onClick GoToCommunity ] [ text "Community" ]
            , button [ onClick (MsgUserWrapper Logout) ] [ text "Logout" ]
            ]
    else
        div [] []



-- Content/Pages --


displayContent : Model -> Html Msg
displayContent model =
    if model.user.connected == False || model.homePage then
        viewHome model
    else if model.dashboardPage then
        viewDash model
    else if model.objectivesPage then
        viewObjectives model
    else if model.challengesPage then
        viewChallenges model
    else if model.testAPIPage then
        viewAPI model
    else if model.communityPage then
        viewCommunity model
    else
        div [] [ text "Page 404 - Not Found" ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
