module Types exposing (..)


type alias WeatherDesc =
    { id : Int
    , main : String
    , description : String
    , icon : String
    }


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
