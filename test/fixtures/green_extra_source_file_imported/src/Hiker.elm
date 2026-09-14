module Hiker exposing (answer)

import Checksum


answer : Int
answer =
    6 * Checksum.checksum
