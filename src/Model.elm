module Model exposing (..)

import Types exposing (..)
import Messages exposing (Msg)


---- MODEL ----


type alias Model =
    { user : User
    , currentName : String
    , currentPassword : String
    , homePage : Bool
    , dashboardPage : Bool
    , objectivesPage : Bool
    , challengesPage : Bool
    , testAPIPage : Bool
    , activities : List Activity
    , destinations : List Destination
    , kmsAchieved : Float
    , challenges : List Challenge
    , setObjForm : Bool
    , newObjName : String
    , newObjKms : String
    , gifUrl : String
    , weather : String
    , weatherTemp : Float
    , error : String
    }


initialModel : Model
initialModel =
    { user =
        { name = ""
        , password = ""
        , status = "String"
        , connected = False
        }
    , currentName = ""
    , currentPassword = ""
    , homePage = True
    , dashboardPage = False
    , objectivesPage = False
    , challengesPage = False
    , testAPIPage = False
    , activities =
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
    , destinations =
        [ { name = "Marseille => Aix"
          , kms = 34
          , percent = round (66 * 100 / 34)
          , filling = round (66 * 300 / 34)
          , own = False
          }
        , { name = "Lille => Hardelot"
          , kms = 115
          , percent = round (66 * 100 / 115)
          , filling = round (66 * 300 / 115)
          , own = False
          }
        , { name = "Paris => Lille"
          , kms = 225
          , percent = round (66 * 100 / 225)
          , filling = round (66 * 300 / 225)
          , own = False
          }
        , { name = "Paris => Barcelone"
          , kms = 1069
          , percent = round (66 * 100 / 1069)
          , filling = round (66 * 300 / 1069)
          , own = False
          }
        ]
    , kmsAchieved = 66.0
    , challenges =
        [ { name = "Travel from Paris to Brussels"
          , kms = 312.0
          , participants =
                [ { name = "Guillaume"
                  , kms = 56.7
                  }
                ]
          , own = False
          }
        , { name = "Travel from Lille to London"
          , kms = 284.0
          , participants =
                [ { name = "Guillaume"
                  , kms = 56.7
                  }
                , { name = "Charles"
                  , kms = 134.5
                  }
                , { name = "Loréleine"
                  , kms = 67.8
                  }
                ]
          , own = False
          }
        ]
    , setObjForm = False
    , newObjName = ""
    , newObjKms = ""
    , gifUrl = ""
    , weather = ""
    , weatherTemp = 0.0
    , error = ""
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )
