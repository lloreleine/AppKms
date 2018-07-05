module Main exposing (..)

import Messages exposing (..)
import Model exposing (init, Model)
import Update exposing (update)
import Home exposing (viewHome)
import Dashboard exposing (viewDash)
import Objectives exposing (viewObjectives)
import Challenges exposing (viewChallenges)
import Html exposing (Html, text, div, img, input, button, form, label)
import Html.Attributes exposing (src, class, type_, value, name, disabled, checked)
import Html.Events exposing (onInput, onClick, onSubmit)


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
            , button [ onClick (MsgUserWrapper Logout) ] [ text "Logout" ]
            ]
    else
        div [] []



-- Content/Pages --


displayContent : Model -> Html Msg
displayContent model =
    if model.home then
        viewHome model
    else if model.dashboard then
        viewDash model
    else if model.objectives then
        viewObjectives model
    else if model.challenges then
        viewChallenges model
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
