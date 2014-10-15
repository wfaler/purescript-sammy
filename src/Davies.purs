module Davies
(sammy, get, SammyCtx(..), runApp, AppRunning(..))
where

import Data.Maybe
import qualified Control.Monad.JQuery as J
import Control.Monad.Eff

foreign import data SammyCtx :: *
foreign import data AppRunning :: !
foreign import data RouteResponse :: !

foreign import sammy
"function sammy(selector){return function() { return Sammy(selector, function(app){ return app;})}}" :: forall a eff. String -> Eff (app :: a | eff) SammyCtx

foreign import runApp
"function runApp(app){ return function(route){ return function (){ app.run(route);};};}" :: forall eff. SammyCtx -> String -> Eff (app :: AppRunning | eff) Unit 

foreign import get
"function get(smy){return function(path){return function(fn){ return function(){smy.get(path,fn(smy));};};};}" :: forall b c eff. SammyCtx -> String -> (SammyCtx -> Eff (app :: b | eff) c) -> Eff (app :: b | eff) c

foreign import post
"function post(smy){return function(path){return function(fn){ return function(){smy.post(path,fn(smy));};};};}" :: forall b c eff. SammyCtx -> String -> (SammyCtx -> Eff (app :: b | eff) c) -> Eff (app :: b | eff) c

foreign import put
"function put(smy){return function(path){return function(fn){ return function(){smy.put(path,fn(smy));};};};}" :: forall b c eff. SammyCtx -> String -> (SammyCtx -> Eff (app :: b | eff) c) -> Eff (app :: b | eff) c

foreign import delete
"function delete(smy){return function(path){return function(fn){ return function(){smy.delete(path,fn(smy));};};};}" :: forall b c eff. SammyCtx -> String -> (SammyCtx -> Eff (app :: b | eff) c) -> Eff (app :: b | eff) c
