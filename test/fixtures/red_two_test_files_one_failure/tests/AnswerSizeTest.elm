module AnswerSizeTest exposing (suite)

import Expect
import Hiker
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "answer size"
        [ test "the answer is two digits long" <|
            \_ ->
                String.length (String.fromInt Hiker.answer)
                    |> Expect.equal 2
        , test "the answer is three digits long" <|
            \_ ->
                String.length (String.fromInt Hiker.answer)
                    |> Expect.equal 3
        ]
