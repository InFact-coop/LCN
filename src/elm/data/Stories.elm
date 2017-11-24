module Data.Stories exposing (..)

import Types exposing (..)


stories =
    [ Story MadeMyDay "I had a good day" 3 Housing "Manchester"
    , Story MadeMyDay "I had a great day" 2 Housing "Newcastle"
    , Story MadeMyDay "I had a pretty ok day" 6 MentalHealth "Preston"
    , Story Bug "I had an annoying thing happen ok day" 3 MentalHealth "Bristol"
    , Story ISpy "I can't find my keys" 2 Crime "Derby"
    , Story Bug "Make this app better!" 10 Crime "Chester"
    ]
