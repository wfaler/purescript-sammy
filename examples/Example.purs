module Example
(main)
where

import Sammy
import qualified Control.Monad.JQuery as J
import Debug.Trace

main = do
  mainApp <- sammy "#main"
  get mainApp "#/" getR
  post mainApp "#/event" postEventR
  get mainApp "#/event" getEventR
  bindEvent mainApp "myEvent" myEventHandler
  bindEvent mainApp "myEvent1" myEventHandler1
  runApp mainApp "#/"

getR context = do
  foo <- params context "foo"
  b <- J.select "#main"
  div <- J.create "<div id='my foo'>"
  trigger context "myEvent1"
  J.appendText (show foo) div
  J.append div b

postEventR context = do
  trigger context "myEvent"
  redirect context "#/event"

getEventR context = do
  trace "at #/event"

myEventHandler ctx = do
  trace "myEvent triggered"

myEventHandler1 ctx = do
  trace "myEvent1 triggered by get"
