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
        , test "the checksum of the answer" <|
            \_ ->
                Hiker.checksum Hiker.answer
                    |> Expect.equal 0
        ]
