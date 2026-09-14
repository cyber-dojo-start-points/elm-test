module AnswerSizeTest exposing (suite)

import Expect
import Hiker
import Test exposing (Test, test)


suite : Test
suite =
    test "the answer is three digits long" <|
        \_ ->
            String.length (String.fromInt Hiker.answer)
                |> Expect.equal 3
