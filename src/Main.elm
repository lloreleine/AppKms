module Main exposing (..)

import Dashboard exposing (viewDash)
import Html exposing (Html, text, div, img, input, button, form, label)
import Html.Attributes exposing (src, class, type_, value, name, disabled, checked)
import Html.Events exposing (onInput, onClick, onSubmit)


---- MODEL ----


type alias Model =
    { connected : Bool
    , current : String
    , username : String
    , home : Bool
    , dashboard : Bool
    , objectives : Bool
    , challenges : Bool
    }


initialModel : Model
initialModel =
    { connected = False
    , current = ""
    , username = ""
    , home = True
    , dashboard = False
    , objectives = False
    , challenges = False
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = SaveName String
    | Register
    | GoToHome
    | GoToDashboard
    | GoToObjectives
    | GoToChallenges
    | Logout


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

        GoToHome ->
            ( { model
                | home = True
                , dashboard = False
                , objectives = False
                , challenges = False
              }
            , Cmd.none
            )

        GoToDashboard ->
            ( { model
                | dashboard = True
                , home = False
                , objectives = False
                , challenges = False
              }
            , Cmd.none
            )

        GoToObjectives ->
            ( { model
                | objectives = True
                , home = False
                , dashboard = False
                , challenges = False
              }
            , Cmd.none
            )

        GoToChallenges ->
            ( { model
                | challenges = True
                , home = False
                , dashboard = False
                , objectives = False
              }
            , Cmd.none
            )

        Logout ->
            ( { model
                | connected = False
                , current = ""
                , username = ""
                , home = True
                , dashboard = False
              }
            , Cmd.none
            )



---- VIEW ----
-- Home Page --


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



-- Objectives Page --


viewObjectives : Model -> Html Msg
viewObjectives model =
    div [ class "container-objectives" ]
        [ text "Objectives Page" ]



-- Challenges Page --


viewChallenges : Model -> Html Msg
viewChallenges model =
    div [ class "container-challenges" ]
        [ text "Challenges Page" ]



-- Menu --


displayMenu : Model -> Html Msg
displayMenu model =
    if (String.isEmpty model.username) then
        div [] []
    else
        div [ class "menu" ]
            [ text "Menu"
            , button [ onClick GoToHome ] [ text "Home" ]
            , button [ onClick GoToDashboard ] [ text "Dashboard" ]
            , button [ onClick GoToObjectives ] [ text "Objectives" ]
            , button [ onClick GoToChallenges ] [ text "Challenges" ]
            , button [ onClick Logout ] [ text "Logout" ]
            ]


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


view : Model -> Html Msg
view model =
    div [ class "global" ]
        [ displayMenu model
        , displayContent model
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
