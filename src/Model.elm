module Model exposing (..)

import Types exposing (..)
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
    , newObjName : String
    , newObjKms : String
    , ownObjectives : List Objectives
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
    , newObjName = ""
    , newObjKms = "0"
    , ownObjectives = []
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )
