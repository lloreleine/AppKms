module Dashboard exposing (viewDash)

import Objectives exposing (viewObjectives)
import Html exposing (Html, text, div, img, input, button, form, label, table, thead, th, tbody, td, tr, ul, li)
import Html.Attributes exposing (src, class, type_, value, name, disabled, checked, style)


type alias Activity =
    { date : String
    , duration : Int
    , kms : Int
    , typeOf : String
    }


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
            , { date = "03/07/2018"
              , duration = 70
              , kms = 12
              , typeOf = "Running"
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
