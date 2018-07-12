module SetObjective exposing (setObjective)

import Messages exposing (..)
import Model exposing (init, Model)
import Html exposing (Html, text, div, input, button)
import Html.Attributes exposing (class, type_, value, disabled)
import Html.Events exposing (onClick, onInput)


setObjective : Model -> Html Msg
setObjective model =
    div [ class "set-objective" ]
        [ div [] [ text "Set your own Objective" ]
        , button [ class "btn-set-objective", onClick DisplayObjectiveForm ] [ text ">" ]
        , displayFormObj model
        ]


displayFormObj : Model -> Html Msg
displayFormObj model =
    if model.setObjForm then
        div
            [ class "form-setObj" ]
            [ div []
                [ text "Please, enter the name of your objective:"
                , input
                    [ type_ "text"
                    , value model.newObjName
                    , onInput SaveNewObjectiveName
                    , class "input-setObj"
                    ]
                    []
                ]
            , div []
                [ text "Please, enter the number of kms:"
                , input
                    [ type_ "text"
                    , onInput SaveNewObjectiveKms
                    , class "input-setObj"
                    ]
                    []
                ]
            , div []
                [ button
                    [ disabled (String.isEmpty model.newObjName)
                    , type_ "submit"
                    , onClick AddObjective
                    ]
                    [ text "Add Objective" ]
                ]
            ]
    else
        div [] []
