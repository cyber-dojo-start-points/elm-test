module HikerTest exposing (suite)

import Expect
import Hiker
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "hiker"
        [ test "to life the universe and everything" <|
            \_ ->
                Hiker.answer
                    |> Expect.equal 42
        , test "the answer is even" <|
            \_ ->
                modBy 2 Hiker.answer
                    |> Expect.equal 0
        ]
