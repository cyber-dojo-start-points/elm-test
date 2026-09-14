module Hiker exposing (answer)


{-| The learner put a Debug.log inside a map to see what was happening, and it
prints far more than the 50K the runner keeps.
-}
answer : Int
answer =
    let
        _ =
            List.map noisy (List.range 1 5000)
    in
    6 * 9


noisy : Int -> Int
noisy i =
    Debug.log "debug: answer was called, i is" i
