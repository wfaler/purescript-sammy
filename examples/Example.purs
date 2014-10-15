module Example
(main)
where

import Davies
import Debug.Trace

main = do
  app <- sammy "#main"
  get app "#/" getR
  runApp app "#/"


getR context = do
  trace "in get #/"
