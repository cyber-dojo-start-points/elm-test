module AnswerSizeTest exposing (suite)

import Expect
import Test exposing (Test, test)


{-| elm-test gathers tests from tests/ and from any depth below it, so what
decides whether a test module runs is the directory it is in rather than what
it is called. This file sits beside elm.json instead, so it is neither gathered
by elm-test nor type-checked by cyber-dojo.sh, which looks only in the
source-directories elm.json names.

The assertion is one that would fail, so that a green says it really did not
run rather than that it ran and passed.
-}
suite : Test
suite =
    test "the answer is three digits long" <|
        \_ ->
            String.length "42"
                |> Expect.equal 3
