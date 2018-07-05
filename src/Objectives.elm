module Objectives exposing (viewObjectives)

import Messages exposing (..)
import Model exposing (init, Model)
import SetObjective exposing (setObjective)
import Html exposing (Html, text, div, img, input, button, form, label, table, thead, th, tbody, td, tr, ul, li)
import Html.Attributes exposing (src, class, type_, value, name, disabled, checked, style)
import Html.Events exposing (onClick)


viewObjectives : Model -> Html Msg
viewObjectives model =
    div [ class "container-objectives" ]
        [ text "Objectives Page"
        , displayTitle model.user.name
        , displayObjectives model
        ]



-- Title of the page --


displayTitle : String -> Html msg
displayTitle name =
    div [ class "subtitle-objectives" ]
        [ text ("Those are your objectives, " ++ name ++ ":") ]



-- Content --


displayObjectives : Model -> Html Msg
displayObjectives model =
    let
        -- unused variable but keep it for the calculation in DB --
        totalKms =
            (List.map .kms model.activities)
                |> List.foldl (\x a -> x + a) 0
    in
        div []
            [ text ("Kms achieved: " ++ toString model.kmsAchieved)
            , displayProgressionBar model
            , setObjective model
            ]


displayProgressionBar : Model -> Html Msg
displayProgressionBar model =
    div []
        (List.map
            (\destination ->
                div [ class "container-prog-bar" ]
                    [ div
                        [ class "prog-bar-global" ]
                        [ div
                            [ style
                                [ ( "background-color", "lightsalmon" )
                                , if destination.filling > 300 then
                                    ( "width", "300px" )
                                  else
                                    ( "width", (toString (destination.filling)) ++ "px" )
                                ]
                            ]
                            [ if destination.percent > 100 then
                                text "100%"
                              else
                                text (toString (destination.percent) ++ "%")
                            ]
                        ]
                    , div [ class "prog-bar-annotations" ] [ text ("/ " ++ (toString destination.kms) ++ " kms - " ++ destination.name) ]
                    , if destination.own then
                        button
                            [ class "btn-delete-own-objective"
                            , onClick (DeleteOwnObjective destination.name)
                            ]
                            [ text "X" ]
                      else
                        div [] []
                    ]
            )
            model.destinations
        )
