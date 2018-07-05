module Dashboard exposing (viewDash)

import Messages exposing (..)
import Model exposing (init, Model)
import Html exposing (Html, text, div, img, input, button, form, label, table, thead, th, tbody, td, tr, ul, li)
import Html.Attributes exposing (src, class, type_, value, name, disabled, checked, style)


viewDash : Model -> Html Msg
viewDash model =
    div [ class "container-dash" ]
        [ text "Dashboard"
        , displayTitle model.user.name
        , displayActivities model
        ]



-- Title of the page --


displayTitle : String -> Html msg
displayTitle name =
    div [ class "subtitle-activities" ]
        [ text ("This is your activity, " ++ name ++ ":") ]



-- Content --


displayActivities : Model -> Html msg
displayActivities model =
    div []
        [ table
            [ class "table-activities" ]
            [ thead []
                [ th [] [ text "Date" ]
                , th [] [ text "Duration" ]
                , th [] [ text "Distance" ]
                , th [] [ text "Activity" ]
                ]
            , tbody []
                (List.map
                    (\activity ->
                        tr []
                            [ td [] [ text activity.date ]
                            , td [] [ text (toString activity.duration ++ " min") ]
                            , td [] [ text (toString activity.kms ++ " kms") ]
                            , td [] [ text activity.typeOf ]
                            ]
                    )
                    model.activities
                )
            ]
        ]
