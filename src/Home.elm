module Home exposing (viewHome)

import Messages exposing (..)
import Model exposing (init, Model)
import Types exposing (..)
import Html exposing (Html, text, div, img, input, button, form, label)
import Html.Attributes exposing (src, class, type_, value, name, disabled, checked)
import Html.Events exposing (onInput, onClick, onSubmit)


---- VIEW ----


viewHome : Model -> Html Msg
viewHome model =
    div [ class "container-home" ]
        [ text "Welcome to App Kilometer"
        , displayForm model
        , displayGreetings model.username
        ]


displayForm : Model -> Html Msg
displayForm model =
    if model.connected == False then
        form [ class "form-connect", onSubmit Register ]
            [ text "Please, enter your name:"
            , input
                [ type_ "text"
                , value model.current
                , onInput SaveName
                , class "input"
                ]
                []
            , button
                [ disabled (String.isEmpty model.current)
                , onClick Register
                ]
                [ text "Connexion" ]
            ]
    else
        div [] [ text "" ]


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
                ]
