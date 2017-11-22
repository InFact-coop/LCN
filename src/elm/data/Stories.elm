module Data.Stories exposing (..)

import Types exposing (..)


stories =
    [ Story Success "I had a good day" 3 Housing
    , Story Success "I had a great day" 2 Housing
    , Story Success "I had a pretty ok day" 6 Housing
    , Story Bug "I had an annoying thing happen ok day" 3 Housing
    , Story Help "I can't find my keys" 2 Benefit
    , Story Suggest "Make this app better!" 10 Misc
    ]
