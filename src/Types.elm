module Types exposing (..)


type alias Feed =
    { imgUrl : String }


type alias User =
    { name : String
    , password : String
    , status : String
    , connected : Bool
    }


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
