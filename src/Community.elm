module Community exposing (viewCommunity)

import Messages exposing (..)
import Model exposing (init, Model)
import Html exposing (Html, text, div, button, h3, h5, i)
import Html.Attributes exposing (class, src, style)
import Html.Events exposing (onClick)


viewCommunity : Model -> Html Msg
viewCommunity model =
    div [ class "container-community" ]
        [ text "Community Page"
        , displayTitle model.user.name
        , displayCommunity model
        ]



-- Title of the page --


displayTitle : String -> Html msg
displayTitle name =
    div [ class "subtitle-community" ]
        [ text ("Check on your friends, " ++ name ++ ":") ]



-- Content --


displayCommunity : Model -> Html Msg
displayCommunity model =
    div [ class "cards-community" ]
        (List.map
            (\user ->
                div
                    [ class "card-user"
                    , if model.openUserCard == user then
                        class "user-card-open"
                      else
                        class ""
                    , onClick (OpenUserCard user)
                    ]
                    [ div [ class "card-user-name" ]
                        [ i [ class "fas fa-user-circle user-icon" ] []
                        , h3 [] [ text user.name ]
                        ]
                    , div [ class "card-user-sticker" ]
                        [ div [ class "sticker" ] [ text "3" ]
                        ]
                    , div [ class "card-user-kms" ]
                        [ h5 [ class "title-kms-achieved" ] [ text "Kms achevied: " ]
                        , text (toString user.kms ++ "kms")
                        ]
                    ]
            )
            model.community
        )
