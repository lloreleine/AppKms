module Objectives exposing (viewObjectives)

import Messages exposing (..)
import Model exposing (init, Model)
import Types exposing (..)
import SetObjective exposing (setObjective)
import Html exposing (Html, text, div, img, input, button, form, label, table, thead, th, tbody, td, tr, ul, li)
import Html.Attributes exposing (src, class, type_, value, name, disabled, checked, style)


viewObjectives : Model -> Html Msg
viewObjectives model =
    let
        activitiesList =
            [ { date = "28/06/2018"
              , duration = 97
              , kms = 15
              , typeOf = "Running"
              }
            , { date = "01/07/2018"
              , duration = 60
              , kms = 33
              , typeOf = "Biking"
              }
            , { date = "02/07/2018"
              , duration = 40
              , kms = 6
              , typeOf = "Walking"
              }
            , { date = "03/07/2018"
              , duration = 70
              , kms = 12
              , typeOf = "Running"
              }
            ]
    in
        div [ class "container-objectives" ]
            [ text "Objectives Page"
            , displayTitle model.username
            , displayObjectives activitiesList model
            ]



-- Title of the page --


displayTitle : String -> Html msg
displayTitle name =
    div [ class "subtitle-objectives" ]
        [ text ("Those are your objectives, " ++ name ++ ":") ]



-- Content --


displayObjectives : List Activity -> Model -> Html Msg
displayObjectives activitiesList model =
    let
        totalKms =
            (List.map .kms activitiesList)
                |> List.foldl (\x a -> x + a) 0
    in
        div []
            [ text ("Kms achieved: " ++ toString totalKms)
            , displayProgressionBar (toFloat totalKms)
            , setObjective model
            ]


displayProgressionBar : Float -> Html msg
displayProgressionBar totalKms =
    let
        destinationsList : List Types.Destination
        destinationsList =
            [ { name = "Marseille => Aix"
              , kms = 34
              , percent = round (totalKms * 100 / 34)
              , filling = round (totalKms * 300 / 34)
              }
            , { name = "Lille => Hardelot"
              , kms = 115
              , percent = round (totalKms * 100 / 115)
              , filling = round (totalKms * 300 / 115)
              }
            , { name = "Paris => Lille"
              , kms = 225
              , percent = round (totalKms * 100 / 225)
              , filling = round (totalKms * 300 / 225)
              }
            , { name = "Paris => Barcelone"
              , kms = 1069
              , percent = round (totalKms * 100 / 1069)
              , filling = round (totalKms * 300 / 1069)
              }
            ]
    in
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
                        ]
                )
                destinationsList
            )
