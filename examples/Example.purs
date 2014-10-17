module Example
(main)
where

import Sammy
import qualified Control.Monad.JQuery as J
import Debug.Trace

main = do
  mainApp <- sammy "#main"
  get mainApp "#/" (getR mainApp)
  post mainApp "#/event" (postEventR mainApp)
  get mainApp "#/event" getEventR
  bindEvent mainApp "myEvent" myEventHandler
  bindEvent mainApp "myEvent1" myEventHandler1
  runApp mainApp "#/"

getR app context = do
  foo <- params context "foo"
  b <- J.select "#main"
  div <- J.create "<div id='my foo'>"
  trigger app "myEvent1"
  J.appendText (show foo) div
  J.append div b

postEventR app context = do
  trigger app "myEvent"
  redirect context "#/event"

getEventR context = do
  foo <- params context "foo"
  trace ("at #/event" ++ (show foo))

myEventHandler ctx = do
  trace "myEvent triggered"

myEventHandler1 ctx = do
  trace "myEvent1 triggered by get"
