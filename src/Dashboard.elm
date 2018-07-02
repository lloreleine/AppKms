module Dashboard exposing (viewDash)

import Html exposing (Html, text, div, img, input, button, form, label, table, thead, th, tbody, td, tr, ul, li)
import Html.Attributes exposing (src, class, type_, value, name, disabled, checked, style)


type alias Activity =
    { date : String
    , duration : Int
    , kms : Int
    , typeOf : String
    }


type alias Destination =
    { name : String
    , kms : Float
    }


displayProgressionBar totalKms =
    let
        destinationsList : List Destination
        destinationsList =
            [ { name = "Marseille => Aix"
              , kms = 34
              }
            , { name = "Lille => Hardelot"
              , kms = 115
              }
            , { name = "Paris => Lille"
              , kms = 225
              }
            , { name = "Paris => Barcelone"
              , kms = 1069
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
                                    [ ( "background-color", "papayawhip" )
                                    , ( "width", (toString (totalKms * 300 / destination.kms)) ++ "px" )
                                    ]
                                ]
                                [ text ((toString (totalKms * 100 / destination.kms)) ++ "%") ]
                            ]
                        , div [ class "prog-bar-annotations" ] [ text ("/ " ++ (toString destination.kms) ++ " kms - " ++ destination.name) ]
                        ]
                )
                destinationsList
            )


displayKms activitiesList =
    let
        totalKms =
            (List.map .kms activitiesList)
                |> List.foldl (\x a -> x + a) 0
    in
        div []
            [ text "Kms achieved: "
            , text (toString totalKms)
            , displayProgressionBar totalKms
            ]


displayActivities =
    let
        activitiesList : List Activity
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
            ]
    in
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
                        activitiesList
                    )
                ]
            , displayKms activitiesList
            ]


displayTitle : String -> Html msg
displayTitle name =
    div [ class "subtitle-activities" ]
        [ text ("This is your activity, " ++ name ++ ":") ]


viewDash model =
    div [ class "container-dash" ]
        [ text "Dashboard"
        , displayTitle model.username
        , displayActivities
        ]
