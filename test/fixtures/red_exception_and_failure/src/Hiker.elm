module Hiker exposing (answer, checksum)


answer : Int
answer =
    6 * 9


{-| checksum takes an argument, so its body is evaluated when a test calls it
rather than when the module loads. elm-test catches what Debug.todo throws and
reports it against the test that ran into it, the same way it reports an
assertion that did not hold.
-}
checksum : Int -> Int
checksum n =
    Debug.todo "work out the checksum"
