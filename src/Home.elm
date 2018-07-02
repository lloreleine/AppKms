module Home exposing (viewHome)

import Html exposing (Html, text, div, img, input, button, form, label)
import Html.Attributes exposing (src, class, type_, value, name, disabled, checked)
import Html.Events exposing (onInput, onClick)


---- VIEW ----


viewHome : Model -> Html Msg
viewHome model =
    div [ class "container" ]
        [ text "Welcome to App Kilometer"
        , displayForm model
        , displayName model.username
        ]


displayForm : Model -> Html Msg
displayForm model =
    if model.connected == False then
        form [ onSubmit Register ]
            [ input
                [ type_ "text"
                , value model.current
                , onInput SaveName
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


displayName : String -> Html Msg
displayName name =
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
