module FizzBuzzTest exposing (suite)

import Expect
import FizzBuzz
import Test exposing (Test, test)


{-| Elm works out a module's name from its file's path, so renaming a file
means renaming the module inside it. Both files here are renamed, and both
modules with them.
-}
suite : Test
suite =
    test "to life the universe and everything" <|
        \_ ->
            FizzBuzz.fizzBuzz
                |> Expect.equal 42
