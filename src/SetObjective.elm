module SetObjective exposing (setObjective)

import Messages exposing (..)
import Model exposing (init, Model)
import Html exposing (Html, text, div, input, button, form, label)
import Html.Attributes exposing (src, class, type_, value)
import Html.Events exposing (onClick)


setObjective : Model -> Html Msg
setObjective model =
    div [ class "set-objective" ]
        [ div [] [ text "Set your own Objective" ]
        , button [ class "btn-set-objective", onClick DisplayForm ] [ text "+" ]
        , displayFormObj model
        ]


displayFormObj : Model -> Html msg
displayFormObj model =
    if model.setObjForm then
        div [] [ text "yes" ]
    else
        div [] [ text "no" ]
