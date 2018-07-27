package com.AUI
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public dynamic class Container extends Sprite
   {
      
      private static const FIX:BitmapData = new BitmapData(1,1);
       
      
      public var _HB:HScrollBar;
      
      public var _VB:VScrollBar;
      
      public var _BG:DisplayObject;
      
      public var _wrapper:Sprite;
      
      protected var _items:Sprite;
      
      private var _window:Rectangle;
      
      public function Container()
      {
         super();
         if(_wrapper == null)
         {
            _wrapper = new Sprite();
            _wrapper.graphics.beginFill(0,0);
            _wrapper.graphics.drawRect(0,0,this.width,this.height);
         }
         _wrapper.mouseEnabled = false;
         addChild(_wrapper);
         _window = new Rectangle(0,0,_wrapper.width,_wrapper.height);
         _wrapper.scrollRect = _window;
         _items = new Sprite();
         _items.mouseEnabled = false;
         _wrapper.addChild(_items);
         if(_HB)
         {
            _HB.x = 0;
            _HB.y = this.height - _HB.height;
            _HB.attach(_window,_items);
            _HB.addEventListener("mouseWheel",onMouseWheelScrollBar,false,1,true);
            _HB.width = this.width;
            addChild(_HB);
         }
         if(_VB)
         {
            _VB.x = this.width - _VB.width;
            _VB.y = 0;
            _VB.attach(_window,_items);
            _VB.addEventListener("mouseWheel",onMouseWheelScrollBar,false,1,true);
            _VB.height = this.height;
            addChild(_VB);
         }
         if(!_BG)
         {
            _BG = new Sprite();
            addChildAt(_BG,0);
         }
         updateScrollBar();
         addEventListener("mouseWheel",onMouseWheel);
      }
      
      public function getHBar() : HScrollBar
      {
         return _HB;
      }
      
      public function getVBar() : VScrollBar
      {
         return _VB;
      }
      
      public function get overflowX() : Boolean
      {
         return _window.width < _items.width;
      }
      
      public function get overflowY() : Boolean
      {
         return _window.height < _items.height;
      }
      
      public function get numItems() : int
      {
         return _items.numChildren;
      }
      
      public function get windowWidth() : int
      {
         return _window.width;
      }
      
      public function set windowWidth(param1:int) : void
      {
         _window.width = param1;
         _BG.width = param1;
         _wrapper.scrollRect = _window;
         FIX.draw(_wrapper);
      }
      
      public function get windowHeight() : int
      {
         return _window.height;
      }
      
      public function set windowHeight(param1:int) : void
      {
         _window.height = param1;
         _BG.height = param1;
         _wrapper.scrollRect = _window;
         FIX.draw(_wrapper);
      }
      
      public function setWindow(param1:int, param2:int) : void
      {
         _window.width = param1;
         _window.height = param2;
         _BG.width = param1;
         _BG.height = param2;
         _wrapper.scrollRect = _window;
         FIX.draw(_wrapper);
      }
      
      public function getItemAt(param1:int) : DisplayObject
      {
         return _items.getChildAt(param1);
      }
      
      public function getItemByName(param1:String) : DisplayObject
      {
         return _items.getChildByName(param1);
      }
      
      public function getItemIndex(param1:DisplayObject) : int
      {
         return _items.getChildIndex(param1);
      }
      
      public function addItem(param1:DisplayObject) : DisplayObject
      {
         return addItemAt(param1,_items.numChildren);
      }
      
      public function removeItem(param1:DisplayObject) : DisplayObject
      {
         return removeItemAt(_items.getChildIndex(param1));
      }
      
      public function addItemAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         _items.addChildAt(param1,param2);
         updateScrollBar();
         return param1;
      }
      
      public function removeItemAt(param1:int) : DisplayObject
      {
         var _loc2_:DisplayObject = _items.removeChildAt(param1);
         updateScrollBar();
         return _loc2_;
      }
      
      public function removeItemByName(param1:String) : DisplayObject
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:DisplayObject = null;
         _loc2_ = 0;
         _loc4_ = _items.numChildren;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = _items.getChildAt(_loc2_);
            if(_loc3_.name == param1)
            {
               removeItemAt(_loc2_);
               break;
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function replaceItemAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         var _loc3_:DisplayObject = _items.removeChildAt(param2);
         _items.addChildAt(param1,param2);
         updateScrollBar();
         return _loc3_;
      }
      
      public function removeItems() : void
      {
         var _loc1_:int = _items.numChildren;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _items.removeChildAt(0);
         }
         updateScrollBar();
      }
      
      public function setItemsWidth(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _loc2_ = 0;
         _loc4_ = _items.numChildren;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = _items.getChildAt(_loc2_);
            if(_loc3_.width != param1)
            {
               _loc3_.width = param1;
            }
            _loc2_++;
         }
      }
      
      protected function onMouseWheel(param1:MouseEvent) : void
      {
         if(_VB && _VB.visible)
         {
            _VB.wheelScrollBy(param1.delta);
            return;
         }
         if(_HB && _HB.visible)
         {
            _HB.wheelScrollBy(param1.delta);
            return;
         }
      }
      
      protected function onMouseWheelScrollBar(param1:MouseEvent) : void
      {
         ScrollBar(param1.currentTarget).wheelScrollBy(param1.delta);
         param1.stopImmediatePropagation();
      }
      
      public function updateScrollBar() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Boolean = overflowX;
         var _loc2_:Boolean = overflowY;
         var _loc5_:Boolean = _loc1_ && _loc2_;
         if(_HB)
         {
            if(_loc5_ && _VB)
            {
               _loc4_ = _VB.width;
            }
            if(_loc1_)
            {
               _HB.visible = true;
               _HB.scale = _window.width / _items.width;
            }
            else
            {
               _HB.visible = false;
               _HB.scale = 1;
            }
         }
         if(_VB)
         {
            if(_loc5_ && _HB)
            {
               _loc3_ = _HB.height;
            }
            if(_loc2_)
            {
               _VB.visible = true;
               _VB.scale = _window.height / _items.height;
            }
            else
            {
               _VB.visible = false;
               _VB.scale = 1;
            }
         }
         if(_BG)
         {
            _BG.width = _window.width;
            _BG.height = _window.height;
         }
      }
   }
}
