module Types exposing (..)


type alias Activity =
    { date : String
    , duration : Int
    , kms : Int
    , typeOf : String
    }


type alias Destination =
    { name : String
    , kms : Float
    , percent : Int
    , filling : Int
    , own : Bool
    }
