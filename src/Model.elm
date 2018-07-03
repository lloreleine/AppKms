module Model exposing (..)

import Messages exposing (Msg(GoToDashboard, GoToChallenges))


---- MODEL ----


type alias Model =
    { connected : Bool
    , current : String
    , username : String
    , home : Bool
    , dashboard : Bool
    , objectives : Bool
    , challenges : Bool
    , setObjForm : Bool
    }


initialModel : Model
initialModel =
    { connected = False
    , current = ""
    , username = ""
    , home = True
    , dashboard = False
    , objectives = False
    , challenges = False
    , setObjForm = False
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )
