module Data.Stories exposing (..)

import Types exposing (..)


stories =
    [ Story MadeMyDay "Cleared up a deposit dispute between some young tenants and an aggressive landlord!" 3 Housing "Islington"
    , Story MadeMyDay "Closed a 6 month old case this week!" 6 MentalHealth "Bradford"
    , Story Bug "I had to turn away 6 people this week!" 3 MentalHealth "Bristol"
    , Story Bug "Our system keeps crashing" 3 Community "Bromley"
    , Story Bug "Make this app better!" 10 Crime "Bury"
    , Story ISpy "Seems like a lot of people compared ot last winter" 2 Immigration "Nottingham"
    , Story ISpy "Had a lot of teachers ask about privacy laws" 2 Education "Carlisle"
    , Story ISpy "Street crime cases are rising" 2 Crime "Islington"
    ]
