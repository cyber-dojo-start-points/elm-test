module Checksum exposing (checksum)


{-| Nothing imports this module, so elm-test alone would never look at it and
the tests would pass around it. cyber-dojo.sh type-checks every file in the
source-directories elm.json names, which is what brings this to light.
-}
checksum : Int
checksum =
    7 +
