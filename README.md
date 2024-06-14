<!-- idris
module README

import Data.Alternative
import Data.List
-->

# Best `Alternative`

Additional utilities for `Alternative` interface for Idris 2

## Example

Say, in some pretty-printer, we may want some conditionally connected, say, lists:

```idris
f : Bool -> Bool -> String
f cond1 cond2 = concat $ intersperse "\n" $
  [ "some line at the beginning"
  , "some another line"
  ] ++
  whenT cond1 "line under condition 1" ++
  [ "an intermediate line"
  ] ++
  whenTs cond2
    [ "one of two lines under condition 2"
    , "another line under condition 2"
    ]
```
