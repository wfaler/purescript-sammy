module Sammy
(redirect, bindEvent,trigger,params,sammy,runApp,get,put,post,del, SammyCtx(..), Sammy(..),SammyApp(..))
where

import Control.Monad.Eff

foreign import data SammyCtx :: *
foreign import data SammyApp :: *
foreign import data Sammy :: !

foreign import sammy
"""function sammy(selector){
     return function() {
       return Sammy(selector, function(app){
         return app;
       });
     };
   }""":: forall a eff. String -> Eff (app :: Sammy | eff) SammyApp

foreign import runApp
"""function runApp(app){
     return function(route){
       return function (){
         app.run(route);
       };
     };
   }""" :: forall eff. SammyApp -> String -> Eff (app :: Sammy | eff) Unit 

foreign import get
"""function get(smy){
    return function(path){
      return function(fn){
        return function(){
          smy.get(path,function(s){
            fn(s)();
          });
        };
      };
    };
  }""":: forall a eff. SammyApp -> String -> (SammyCtx -> Eff (app :: Sammy | eff) a) -> Eff (app :: Sammy | eff) a

foreign import post
"""function post(smy){
    return function(path){
      return function(fn){
        return function(){
          smy.post(path,function(s){
            fn(s)();
          });
        };
      };
    };
  }""" :: forall a eff. SammyApp -> String -> (SammyCtx -> Eff (app :: Sammy | eff) a) -> Eff (app :: Sammy | eff) a

foreign import put
"""function put(smy){
    return function(path){
      return function(fn){
        return function(){
          smy.put(path,function(s){
            fn(s)();
          });
        };
      };
    };
  }""" :: forall a eff. SammyApp -> String -> (SammyCtx -> Eff (app :: Sammy | eff) a) -> Eff (app :: Sammy | eff) a

foreign import del
"""function del(smy){
    return function(path){
      return function(fn){
        return function(){
          smy.route('delete',path,function(s){
            fn(s)();
          });
        };
      };
    };
  }""" :: forall a eff. SammyApp -> String -> (SammyCtx -> Eff (app :: Sammy | eff) a) -> Eff (app :: Sammy | eff) a

foreign import params
"""function params(smy){
     return function(paramName){
       return function(){
         var p = smy.params[paramName];
         if($.type(p) === 'string'){
           return [p];
         }else if($.type(p) === 'undefined'){
           return [];
         }else{
           return p;
         }
       };
     };
   }""" :: forall eff. SammyCtx -> String -> Eff (app :: Sammy | eff) [String]

foreign import trigger
"""function trigger(smy){
     return function(evt){
       return function(){
         smy.trigger(evt);
       };
     };
   }""" :: forall eff. SammyApp -> String -> Eff (app :: Sammy | eff) Unit

foreign import bindEvent
"""function bindEvent(smy){
     return function(evt){
       return function(fn){
         return function(){
           smy.bind(evt,function(s){
             fn(s)()
           });
         };
       };
     };
   }""" :: forall eff. SammyApp -> String -> (SammyCtx -> (Eff (app :: Sammy | eff) Unit)) ->  Eff (app :: Sammy | eff) Unit

foreign import redirect
"""function redirect(smy){
     return function(route){
       return function(){
         smy.redirect(route);
       };
     };
   }""" :: forall eff. SammyCtx -> String -> Eff (app :: Sammy | eff) Unit
