module Hiker exposing (answer)


{-| The learner is watching what the answer comes out as, and has not taken
this out yet. Debug.log writes to stdout, and cyber-dojo.sh folds elm-test's
stderr into stdout as well, so there is one stream either way.
-}
answer : Int
answer =
    Debug.log "answer was called" (6 * 7)
