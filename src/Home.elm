module Home exposing (viewHome)

import Messages exposing (..)
import Model exposing (init, Model)
import Html exposing (Html, text, div, input, button, form)
import Html.Attributes exposing (class, type_, value, name, disabled)
import Html.Events exposing (onInput, onClick, onSubmit)


---- VIEW ----


viewHome : Model -> Html Msg
viewHome model =
    div [ class "container-home" ]
        [ text "Welcome to App Kilometer"
        , displayForm model
        , displayGreetings model.user.name
        ]



-- Connection form --


displayForm : Model -> Html Msg
displayForm model =
    if model.user.connected == False then
        form [ class "form-connect", onSubmit (MsgUserWrapper Register) ]
            [ text "Please, enter your name:"
            , input
                [ type_ "text"
                , value model.currentName
                , onInput SaveName
                , class "input"
                ]
                []
            , text "And your password:"
            , input
                [ type_ "password"
                , value model.currentPassword
                , onInput SavePassword
                , class "input"
                ]
                []
            , button
                [ disabled (String.isEmpty model.currentName)
                , onClick (MsgUserWrapper Register)
                , class "btn-connection"
                ]
                [ text "Connect" ]
            ]
    else
        div [] [ text "" ]



-- Greetings --


displayGreetings : String -> Html Msg
displayGreetings name =
    let
        greetings =
            "Hello, " ++ name ++ ". "
    in
        if (String.isEmpty name) then
            div [ class "greetings" ]
                [ text "Hello, stranger." ]
        else
            div [ class "greetings" ]
                [ text greetings
                , text "What do you want to do?"
                , button [ class "btn-dash", onClick GoToDashboard ] [ text "Go to my dashboard" ]
                , button [ class "btn-dash", onClick GoToObjectives ] [ text "See my objectives" ]
                , button [ class "btn-dash", onClick GoToChallenges ] [ text "Check on the challenges" ]
                , button [ class "btn-dash", onClick GoToCommunity ] [ text "Discover our community" ]
                ]
