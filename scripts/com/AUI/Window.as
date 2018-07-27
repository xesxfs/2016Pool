package com.AUI
{
   import com.AUI.event.WindowEvent;
   import com.greensock.TweenMax;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.SharedObject;
   
   public class Window extends Sprite
   {
      
      private static var _ED:EventDispatcher = new EventDispatcher();
      
      private static var _SO:SharedObject = null;
      
      private static var _PRI:int = 255;
       
      
      private var _conf:Object = null;
      
      private var _drag:DisplayObject = null;
      
      private var _focusIndex:int = -1;
      
      public var focusNodes:Array;
      
      public var closeHandle:Function = null;
      
      public var closeParams:Array = null;
      
      public var group:int = 0;
      
      public var hotkey:Hotkey;
      
      public var holdKeyBoard:Boolean = false;
      
      public var passKeyBoard:Boolean = false;
      
      public function Window()
      {
         focusNodes = [];
         hotkey = new Hotkey();
         super();
         _PRI = _PRI + 1;
         addEventListener("addedToStage",onAddedToStage);
      }
      
      public static function closeGroup(param1:int) : void
      {
         var _loc2_:WindowEvent = new WindowEvent("closeGroup");
         _loc2_.value = param1;
         _ED.dispatchEvent(_loc2_);
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         addEventListener("removedFromStage",onRemovedFromStage);
         stage.addEventListener("keyDown",onkeydown,false,_PRI,true);
         stage.addEventListener("keyUp",onkeyup,false,_PRI,true);
         _ED.addEventListener("closeGroup",onCloseGroup,false,0,true);
         this.alpha = 0.6;
         TweenMax.to(this,0.4,{"alpha":1});
         stage.focus = focusObject || this;
      }
      
      protected function onRemovedFromStage(param1:Event) : void
      {
         removeEventListener("removedFromStage",onRemovedFromStage);
         addEventListener("addedToStage",onAddedToStage);
         stage.removeEventListener("keyDown",onkeydown);
         stage.removeEventListener("keyUp",onkeyup);
         _ED.removeEventListener("closeGroup",onCloseGroup);
         removeEventListener("mouseUp",onStopDrag);
         stage.removeEventListener("mouseLeave",onStopDrag);
         if(closeHandle != null)
         {
            closeHandle.apply(null,closeParams);
         }
         closeHandle = null;
         stage.focus = stage;
      }
      
      public function allHaveFocus() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         _loc1_ = numChildren;
         while(_loc2_ < _loc1_)
         {
            focusNodes.push(getChildAt(_loc2_));
            _loc2_++;
         }
         focusIndex = 0;
      }
      
      public function register(param1:String) : void
      {
         if(!_SO)
         {
            _SO = SharedObject.getLocal("AUI_REG");
            if(!_SO.data.inited)
            {
               _SO.data.inited = true;
               _SO.data.archives = {};
            }
         }
         _conf = _SO.data.archives[param1];
         if(!_conf)
         {
            _conf = {
               "x":0,
               "y":0
            };
            _SO.data.archives[param1] = {
               "x":0,
               "y":0
            };
         }
         this.x = _conf.x;
         this.y = _conf.y;
      }
      
      protected function onkeydown(param1:KeyboardEvent) : void
      {
         if(passKeyBoard == true)
         {
            return;
         }
         var _loc2_:int = param1.keyCode;
         var _loc3_:* = _loc2_;
         if(27 !== _loc3_)
         {
            if(hotkey.cancel !== _loc3_)
            {
               if(hotkey.next !== _loc3_)
               {
                  if(hotkey.prev !== _loc3_)
                  {
                     if(13 !== _loc3_)
                     {
                        if(hotkey.ok !== _loc3_)
                        {
                           if(holdKeyBoard == false)
                           {
                              return;
                           }
                        }
                     }
                     if(hotkey.oneshot_ok == false)
                     {
                        hotkey.oneshot_ok = true;
                        ok(null);
                     }
                  }
                  else
                  {
                     prevFocus();
                  }
               }
               else
               {
                  nextFocus();
               }
            }
            addr74:
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            param1.preventDefault();
            return;
         }
         if(hotkey.oneshot_cancel == false)
         {
            hotkey.oneshot_cancel = true;
            cancel();
         }
         §§goto(addr74);
      }
      
      protected function onkeyup(param1:KeyboardEvent) : void
      {
         if(passKeyBoard == true)
         {
            return;
         }
         var _loc2_:int = param1.keyCode;
         var _loc3_:* = _loc2_;
         if(27 !== _loc3_)
         {
            if(hotkey.cancel !== _loc3_)
            {
               if(hotkey.next !== _loc3_)
               {
                  if(hotkey.prev !== _loc3_)
                  {
                     if(hotkey.ok !== _loc3_)
                     {
                        if(holdKeyBoard == false)
                        {
                           return;
                        }
                     }
                     else
                     {
                        hotkey.oneshot_ok = false;
                     }
                  }
               }
            }
            addr53:
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            param1.preventDefault();
            return;
         }
         hotkey.oneshot_cancel = false;
         §§goto(addr53);
      }
      
      public function get drag() : DisplayObject
      {
         return _drag;
      }
      
      public function set drag(param1:DisplayObject) : void
      {
         _drag = param1;
         _drag.addEventListener("mouseDown",onStartDrag,false,_PRI,true);
      }
      
      protected function onStartDrag(param1:MouseEvent) : void
      {
         var _loc2_:int = width * 0.5;
         var _loc3_:int = height * 0.5;
         startDrag(false,new Rectangle(-_loc2_,-_loc3_,stage.stageWidth,stage.stageHeight));
         parent.setChildIndex(this,parent.numChildren - 1);
         addEventListener("mouseUp",onStopDrag,false,_PRI,true);
         stage.addEventListener("mouseLeave",onStopDrag,false,_PRI,true);
      }
      
      protected function onStopDrag(param1:Event) : void
      {
         stage.removeEventListener("mouseLeave",onStopDrag);
         removeEventListener("mouseUp",onStopDrag);
         stopDrag();
         if(_conf)
         {
            _conf.x = this.x;
            _conf.y = this.y;
         }
      }
      
      protected function onCloseGroup(param1:WindowEvent) : void
      {
         if(param1.value == group)
         {
            close();
         }
      }
      
      public function get focusObject() : InteractiveObject
      {
         return focusNodes[_focusIndex];
      }
      
      public function get focusIndex() : int
      {
         return _focusIndex;
      }
      
      public function set focusIndex(param1:int) : void
      {
         if(focusObject != null && focusObject.hasOwnProperty("focused") == true)
         {
            Object(focusObject).focused = false;
         }
         _focusIndex = param1;
         if(focusObject != null && focusObject.hasOwnProperty("focused") == true)
         {
            Object(focusObject).focused = true;
         }
         if(focusObject && focusObject.stage)
         {
            stage.focus = focusObject;
         }
      }
      
      public function nextFocus() : void
      {
         var _loc2_:int = focusNodes.length;
         if(_loc2_ == 0)
         {
            return;
         }
         var _loc1_:int = focusIndex;
         _loc1_++;
         if(_loc1_ >= _loc2_)
         {
            _loc1_ = 0;
         }
         focusIndex = _loc1_;
      }
      
      public function prevFocus() : void
      {
         var _loc2_:int = focusNodes.length;
         if(_loc2_ == 0)
         {
            return;
         }
         var _loc1_:int = focusIndex;
         _loc1_--;
         if(_loc1_ < 0)
         {
            _loc1_ = _loc2_ - 1;
         }
         focusIndex = _loc1_;
      }
      
      public function set focusByHover(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = focusNodes;
         for each(var _loc2_ in focusNodes)
         {
            _loc2_.removeEventListener("click",onFocused);
            if(param1)
            {
               _loc2_.addEventListener("click",onFocused,false,_PRI,true);
            }
         }
      }
      
      public function set focusByClick(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = focusNodes;
         for each(var _loc2_ in focusNodes)
         {
            _loc2_.removeEventListener("rollOver",onFocused);
            _loc2_.removeEventListener("click",onClickOk);
            if(param1)
            {
               _loc2_.addEventListener("rollOver",onFocused,false,_PRI,true);
               _loc2_.addEventListener("click",onClickOk,false,_PRI,true);
            }
         }
      }
      
      protected function onFocused(param1:Event) : void
      {
         focusIndex = focusNodes.indexOf(param1.target);
      }
      
      private function onClickOk(param1:MouseEvent) : void
      {
         ok(param1);
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      public function ok(param1:MouseEvent) : void
      {
      }
      
      public function cancel() : void
      {
      }
      
      public function close() : void
      {
         parent.removeChild(this);
      }
   }
}

class Hotkey
{
    
   
   public var next:int = 0;
   
   public var prev:int = 0;
   
   public var ok:int = 0;
   
   public var cancel:int = 0;
   
   public var oneshot_ok:Boolean = false;
   
   public var oneshot_cancel:Boolean = false;
   
   function Hotkey()
   {
      super();
   }
}
