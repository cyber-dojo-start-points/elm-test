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
        , test "the answer is three digits long" <|
            \_ ->
                String.length (String.fromInt Hiker.answer)
                    |> Expect.equal 3
        , test "the answer is odd" <|
            \_ ->
                modBy 2 Hiker.answer
                    |> Expect.equal 1
        ]
