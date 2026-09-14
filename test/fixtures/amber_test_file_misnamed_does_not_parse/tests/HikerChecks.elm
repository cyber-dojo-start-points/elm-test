module HikerChecks exposing (suite)

import Expect
import Hiker
import Test exposing (Test, test)


{-| Named neither HikerTest nor anything else elm-test looks for by name, which
changes nothing: it is the tests/ directory that decides, so this file is
compiled along with the rest. Half written, so it does not parse either.
Vanishing is what it must not do.
-}
suite : Test
suite =
    test "the answer is two digits long" <|
        \_ ->
            String.length (String.fromInt Hiker.answer
                |> Expect.equal 2
