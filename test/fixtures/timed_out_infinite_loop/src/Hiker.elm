module Hiker exposing (answer)


answer : Int
answer =
    countTo42 0


{-| The learner meant to count up to 42 and never moves n. Elm turns a call in
tail position into a loop rather than a stack frame, so this spins instead of
running out of stack, and nothing stops it. elm-test has no clock of its own
here, so the runner is what ends the run.
-}
countTo42 : Int -> Int
countTo42 n =
    if n == 42 then
        n

    else
        countTo42 n
