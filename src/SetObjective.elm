module SetObjective exposing (setObjective)

import Html exposing (Html, text, div, input, button, form, label)
import Html.Attributes exposing (src, class, type_, value)
import Html.Events exposing (onClick)


---- MODEL ----


type alias ModelSetObj =
    { displayForm : Bool
    }


modelSetObj : ModelSetObj
modelSetObj =
    { displayForm = False
    }



---- UPDATE ----


type MsgSetObj
    = DisplayForm


updateSetObj : MsgSetObj -> ModelSetObj -> ModelSetObj
updateSetObj msgSetObj modelSetObj =
    case msgSetObj of
        DisplayForm ->
            { modelSetObj | displayForm = True }



---- VIEW ----


setObjective =
    div [ class "set-objective" ]
        [ div [] [ text "Set your own Objective" ]
        , button [ class "btn-set-objective", onClick DisplayForm ] [ text "+" ]
        ]
