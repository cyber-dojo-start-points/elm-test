module Unit.DeepTest exposing (suite)

import Expect
import Hiker
import Test exposing (Test, test)


{-| A directory under tests/ is part of the module name, so this file has to
say Unit.DeepTest, and Unit has to start with a capital letter. elm-test looks
at any depth below tests/, so nothing else is needed to have this run.
-}
suite : Test
suite =
    test "the answer is two digits long" <|
        \_ ->
            String.length (String.fromInt Hiker.answer)
                |> Expect.equal 2
