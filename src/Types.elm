module Types exposing (..)


type alias User =
    { name : String
    , password : String
    , status : String
    , kms : Float
    , connected : Bool
    , friends : List Friend
    }


type alias Friend =
    { name : String
    , status : FriendStatus
    }


type FriendStatus
    = NoFriendship
    | Pending
    | Validated


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


type alias Challenge =
    { name : String
    , kms : Float
    , participants : List Participant
    , own : Bool
    }


type alias Participant =
    { name : String
    , kms : Float
    }
