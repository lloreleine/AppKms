module Main exposing (..)

import Dashboard exposing (viewDash)
import Html exposing (Html, text, div, img, input, button, form, label)
import Html.Attributes exposing (src, class, type_, value, name, disabled, checked)
import Html.Events exposing (onInput, onClick)


---- MODEL ----


type alias Model =
    { connected : Bool
    , current : String
    , username : String
    }


initialModel : Model
initialModel =
    { connected = False
    , current = ""
    , username = ""
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = SaveName String
    | Register


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaveName name ->
            ( { model | current = name }, Cmd.none )

        Register ->
            ( { model
                | username = model.current
                , connected = True
              }
            , Cmd.none
            )



---- VIEW ----


displayName : String -> Html msg
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
                ]


displayForm : Model -> Html Msg
displayForm model =
    if (model.connected == False) then
        div []
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


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ text "Welcome to App Kilometer"
        , displayForm model
        , displayName model.username
        , viewDash model
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
