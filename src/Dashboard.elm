module Dashboard exposing (viewDash)

import Html exposing (Html, text, div, img, input, button, form, label)
import Html.Attributes exposing (src, class, type_, value, name, disabled, checked)
import Html.Events exposing (onInput, onClick)


---- VIEW ----


displayName : String -> Html msg
displayName name =
    div [ class "dashboard" ]
        [ text ("This is your activity, " ++ name) ]


viewDash model =
    div [ class "container" ]
        [ text "Dashboard"
        , displayName model.username
        ]
