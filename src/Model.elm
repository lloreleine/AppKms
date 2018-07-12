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
    , setChallengeForm : Bool
    , newChallengeName : String
    , newChallengeKms : Float
    , newChallengeParticipants : List Participant
    , setObjForm : Bool
    , newObjName : String
    , newObjKms : Float
    , gifUrl : String
    , weather : String
    , weatherTemp : Float
    , error : String
    , community : List Participant
    }


initialModel : Model
initialModel =
    { user =
        { name = ""
        , password = ""
        , status = "User"
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
                , { name = "Vincent"
                  , kms = 16.3
                  }
                , { name = "Kévin"
                  , kms = 78.5
                  }
                , { name = "Virginie"
                  , kms = 127.9
                  }
                ]
          , own = False
          }
        ]
    , setChallengeForm = False
    , newChallengeName = ""
    , newChallengeKms = 0.0
    , newChallengeParticipants = []
    , setObjForm = False
    , newObjName = ""
    , newObjKms = 0.0
    , gifUrl = ""
    , weather = ""
    , weatherTemp = 0.0
    , error = ""
    , community =
        [ { name = "Guillaume"
          , kms = 56.7
          }
        , { name = "Charles"
          , kms = 134.5
          }
        , { name = "Loréleine"
          , kms = 67.8
          }
        , { name = "Vincent"
          , kms = 16.3
          }
        , { name = "Kévin"
          , kms = 78.5
          }
        , { name = "Virginie"
          , kms = 127.9
          }
        , { name = "Arnaud"
          , kms = 78.4
          }
        , { name = "Thomas"
          , kms = 23.2
          }
        , { name = "Dominique"
          , kms = 5.3
          }
        , { name = "Sandie"
          , kms = 3.8
          }
        , { name = "Thierry"
          , kms = 198.7
          }
        ]
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )
