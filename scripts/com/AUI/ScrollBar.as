package com.AUI
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public dynamic class ScrollBar extends Sprite
   {
      
      public static const HEAD_POSITION:int = 0;
      
      public static const END_POSITION:int = 1;
      
      public static const INVALID_POSITION:int = -1;
       
      
      public var _track:Button;
      
      public var _thumb:Button;
      
      public var setting:SETTING;
      
      private var P:PROFILE#369;
      
      private var _scale:Number = 1;
      
      private var _thumbPosition:Number = -1;
      
      private var _thumbScale:Number = 1;
      
      private var _lastPoint:int = 0;
      
      private var _scrollFunc:Function;
      
      private var _scrollOffset:int = 0;
      
      private var _scrollTime:int = 0;
      
      private var _dst:Object;
      
      private var _box:Object;
      
      public function ScrollBar(param1:Boolean = true)
      {
         setting = new SETTING();
         P = new PROFILE#369();
         super();
         P.V = param1;
         if(P.V)
         {
            P.X = "y";
            P.W = "height";
         }
         else
         {
            P.X = "x";
            P.W = "width";
         }
         if(_track)
         {
            _track.buttonMode = false;
            _track.addEventListener("mouseDown",onMouseDownButtons,false,0,true);
         }
         if(_thumb)
         {
            _thumb.buttonMode = false;
            _thumb.addEventListener("mouseDown",onMouseDownButtons,false,0,true);
            _thumb.addEventListener("rollOut",onRollOutThumb,false,1,true);
         }
         addEventListener("mouseWheel",onMouseWheel);
      }
      
      public function attach(param1:Object, param2:Object) : void
      {
         _box = param1;
         _dst = param2;
         _thumb.visible = true;
      }
      
      public function detach() : void
      {
         _box = null;
         _dst = null;
         _thumb.visible = false;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         var _loc2_:* = param1;
         _thumb.enabled = _loc2_;
         _track.enabled = _loc2_;
      }
      
      public function get vertical() : Boolean
      {
         return P.V;
      }
      
      public function get thumbPosition() : Number
      {
         return _thumbPosition;
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
      
      public function set scale(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Boolean = false;
         if(param1 > 1 || param1 == Infinity || isNaN(param1))
         {
            return;
         }
         var _loc2_:String = P.W;
         var _loc5_:int = _box[_loc2_];
         _scale = param1;
         _loc4_ = _loc5_ * _scale;
         _loc3_ = !!_loc4_?_loc4_ < setting.min_thumb_size:false;
         if(_loc3_)
         {
            _thumbScale = (_loc5_ - setting.min_thumb_size) / (_loc5_ - _loc4_);
            _loc4_ = setting.min_thumb_size;
         }
         else
         {
            _thumbScale = 1;
         }
         if(_thumb[_loc2_] != _loc4_)
         {
            _thumb[_loc2_] = _loc4_;
         }
         if(_track[_loc2_] != _loc4_)
         {
            _track[_loc2_] = _loc5_;
         }
         arrowScrollBy(0);
      }
      
      protected function onMouseWheel(param1:MouseEvent) : void
      {
         wheelScrollBy(param1.delta);
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function onFrame(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - _scrollTime;
         if(_loc3_ < setting.scroll_delay_time)
         {
            return;
         }
         _scrollTime = _loc2_;
         return;
         §§push(_scrollFunc(_scrollOffset));
      }
      
      private function onMouseDownButtons(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc7_:String = P.X;
         var _loc3_:String = P.W;
         var _loc5_:String = "stage" + _loc7_.toLocaleUpperCase();
         var _loc4_:Button = Button(param1.currentTarget);
         var _loc8_:* = _loc4_;
         if(_thumb !== _loc8_)
         {
            if(_track !== _loc8_)
            {
               throw new Error("unkown scrollbar button");
            }
            _scrollFunc = thumbScrollBy;
            _loc6_ = _thumb[_loc3_];
            _loc2_ = _thumb.localToGlobal(new Point(0,0));
            _scrollOffset = param1[_loc5_] < _loc2_[_loc7_]?-_loc6_:_loc6_;
            _loc4_.addEventListener("enterFrame",onFrame,false,0,true);
            _loc4_.addEventListener("rollOut",onMouseCancel,false,0,true);
            _loc4_.addEventListener("mouseUp",onMouseCancel,false,0,true);
            return;
         }
         _scrollFunc = thumbScrollBy;
         _lastPoint = param1[_loc5_];
         stage.addEventListener("mouseMove",onMouseMoveStage,false,0,true);
         stage.addEventListener("mouseUp",onMouseUpStage,false,0,true);
      }
      
      private function onRollOutThumb(param1:MouseEvent) : void
      {
         if(_scrollFunc == thumbScrollBy)
         {
            param1.stopImmediatePropagation();
         }
      }
      
      private function onMouseMoveStage(param1:MouseEvent) : void
      {
         var _loc4_:String = P.X;
         var _loc3_:String = "stage" + _loc4_.toLocaleUpperCase();
         var _loc2_:int = param1[_loc3_];
         thumbScrollBy(_loc2_ - _lastPoint);
         _lastPoint = _loc2_;
      }
      
      private function onMouseUpStage(param1:MouseEvent) : void
      {
         _scrollFunc = null;
         _thumb.dispatchEvent(new MouseEvent("rollOut"));
         param1.currentTarget.removeEventListener("mouseMove",onMouseMoveStage);
         param1.currentTarget.removeEventListener("mouseUp",onMouseUpStage);
      }
      
      private function onMouseCancel(param1:Event) : void
      {
         _scrollFunc = null;
         param1.currentTarget.removeEventListener("enterFrame",onFrame);
         param1.currentTarget.removeEventListener("rollOut",onMouseCancel);
         param1.currentTarget.removeEventListener("mouseUp",onMouseCancel);
      }
      
      public function wheelScrollBy(param1:int) : void
      {
         var _loc2_:int = setting.scroll_steps_wheel;
         arrowScrollBy(-param1 * _loc2_ * (int(param1 * _loc2_ * param1 * _loc2_ / 3)));
         _scrollFunc = null;
      }
      
      public function arrowScrollBy(param1:int) : void
      {
         var _loc6_:String = P.X;
         var _loc2_:String = P.W;
         var _loc5_:Number = _box[_loc2_];
         var _loc7_:Number = _dst[_loc2_];
         var _loc4_:Number = _dst[_loc6_] - param1;
         var _loc3_:Number = -(_loc7_ - _loc5_);
         if(_loc5_ >= _loc7_)
         {
            _thumbPosition = -1;
            return;
         }
         if(_loc4_ >= 0 || _loc7_ < _loc5_)
         {
            _thumbPosition = 0;
            _thumb[_loc6_] = _track[_loc6_];
            _dst[_loc6_] = 0;
         }
         else if(_loc4_ <= _loc3_)
         {
            _thumbPosition = 1;
            _thumb[_loc6_] = _track[_loc6_] + _track[_loc2_] - _thumb[_loc2_];
            _dst[_loc6_] = _loc3_;
         }
         else
         {
            _thumbPosition = -_loc4_ / _loc7_;
            _thumb[_loc6_] = _track[_loc6_] + int(_thumbPosition * _thumbScale * _track[_loc2_]);
            _dst[_loc6_] = _loc4_;
         }
      }
      
      public function thumbScrollBy(param1:int) : void
      {
         var _loc5_:String = P.X;
         var _loc2_:String = P.W;
         var _loc4_:Number = _thumb[_loc2_];
         var _loc6_:Number = _track[_loc2_];
         var _loc3_:Number = _thumb[_loc5_] + param1;
         if(_loc4_ >= _loc6_)
         {
            _thumbPosition = -1;
            return;
         }
         if(_loc3_ <= 0)
         {
            _thumbPosition = 0;
            _thumb[_loc5_] = 0;
            _dst[_loc5_] = 0;
         }
         else if(_loc3_ + _loc4_ >= _loc6_)
         {
            _thumbPosition = 1;
            _thumb[_loc5_] = _track[_loc2_] - _thumb[_loc2_];
            _dst[_loc5_] = _box[_loc2_] - _dst[_loc2_];
         }
         else
         {
            _thumbPosition = _loc3_ / _loc6_;
            _thumb[_loc5_] = _loc3_;
            _dst[_loc5_] = -(int(_thumbPosition / _thumbScale * _dst[_loc2_]));
         }
      }
   }
}

class PROFILE#369
{
    
   
   public var V:Boolean = false;
   
   public var X:String;
   
   public var W:String;
   
   function PROFILE#369()
   {
      super();
   }
}

class SETTING
{
    
   
   public var scroll_steps_wheel:Number = 1;
   
   public var scroll_delay_time:int = 200;
   
   public var min_thumb_size:int = 16;
   
   function SETTING()
   {
      super();
   }
}
