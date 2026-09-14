module Hiker exposing (answer)


{-| answer is a constant, so its body is evaluated as the module loads, before
elm-test has run anything. Debug.todo throws there, the process stops, and no
summary is ever printed.
-}
answer : Int
answer =
    Debug.todo "work out the answer"
