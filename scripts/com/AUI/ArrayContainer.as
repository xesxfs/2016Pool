package com.AUI
{
   import com.AUI.define.EDGE;
   import com.AUI.event.ItemEvent;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ArrayContainer extends Container
   {
       
      
      public var padding:EDGE;
      
      public var itemGap:int;
      
      public var autoFitWidth:Boolean;
      
      public var autoFitHeight:Boolean;
      
      public var maxWidth:int = 2147483647;
      
      public var maxHeight:int = 2147483647;
      
      private var P:PROFILE#266;
      
      public function ArrayContainer(param1:Boolean = false)
      {
         padding = new EDGE();
         P = new PROFILE#266();
         super();
         P.V = param1;
         if(P.V)
         {
            P.X = "y";
            P.Y = "x";
            P.W = "height";
         }
         else
         {
            P.X = "x";
            P.Y = "y";
            P.W = "width";
         }
         _items.addEventListener("mouseUp",onClickItems);
      }
      
      public function get vertical() : Boolean
      {
         return P.V;
      }
      
      protected function onClickItems(param1:MouseEvent) : void
      {
         var _loc3_:DisplayObject = DisplayObject(param1.target);
         while(_loc3_.parent != _items && _loc3_.parent != null)
         {
            _loc3_ = _loc3_.parent;
         }
         var _loc2_:ItemEvent = new ItemEvent("itemClick",true,true);
         _loc2_.index = !!_loc3_.parent?_items.getChildIndex(_loc3_):0;
         _loc2_.value = _loc3_;
         dispatchEvent(_loc2_);
      }
      
      override protected function onMouseWheel(param1:MouseEvent) : void
      {
         if(_VB && _VB.visible)
         {
            _VB.wheelScrollBy(param1.delta);
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            return;
         }
         if(_HB && _HB.visible)
         {
            _HB.wheelScrollBy(param1.delta);
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            return;
         }
      }
      
      override public function addItemAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         var _loc4_:* = null;
         var _loc11_:String = P.X;
         var _loc10_:String = P.Y;
         var _loc5_:String = P.W;
         var _loc3_:Point = new Point();
         var _loc6_:Boolean = false;
         var _loc12_:* = _items.numChildren;
         if(0 !== _loc12_)
         {
            if(param2 !== _loc12_)
            {
               _loc3_[_loc11_] = _items.getChildAt(param2)[_loc11_];
               _loc6_ = true;
            }
            else
            {
               _loc4_ = _items.getChildAt(param2 - 1);
               _loc3_[_loc11_] = _loc4_[_loc11_] + _loc4_[_loc5_] + itemGap;
            }
         }
         else
         {
            _loc3_[_loc11_] = 0;
         }
         param1[_loc11_] = _loc3_[_loc11_];
         param1[_loc10_] = _loc3_[_loc10_];
         _items.addChildAt(param1,param2);
         if(_loc6_)
         {
            realignItems(param2);
         }
         _items.x = padding.left;
         _items.y = padding.top;
         var _loc9_:int = !!autoFitWidth?_items.width:windowWidth;
         var _loc8_:int = !!autoFitHeight?_items.height:windowHeight;
         if(_loc9_ > maxWidth)
         {
            _loc9_ = maxWidth;
         }
         if(_loc8_ > maxHeight)
         {
            _loc8_ = maxHeight;
         }
         _loc9_ = _loc9_ + (padding.left + padding.right);
         _loc8_ = _loc8_ + (padding.top + padding.bottom);
         setWindow(_loc9_,_loc8_);
         updateScrollBar();
         var _loc7_:ItemEvent = new ItemEvent("itemAdd",true,true);
         _loc7_.index = _items.getChildIndex(param1);
         _loc7_.value = param1;
         dispatchEvent(_loc7_);
         return param1;
      }
      
      override public function removeItemAt(param1:int) : DisplayObject
      {
         var _loc3_:DisplayObject = _items.removeChildAt(param1);
         realignItems(param1);
         var _loc5_:int = !!autoFitWidth?_items.width:windowWidth;
         var _loc4_:int = !!autoFitHeight?_items.height:windowHeight;
         if(_loc5_ > maxWidth)
         {
            _loc5_ = maxWidth;
         }
         if(_loc4_ > maxHeight)
         {
            _loc4_ = maxHeight;
         }
         setWindow(_loc5_,_loc4_);
         updateScrollBar();
         var _loc2_:ItemEvent = new ItemEvent("itemDel",true,true);
         _loc2_.index = -1;
         _loc2_.value = _loc3_;
         dispatchEvent(_loc2_);
         return _loc3_;
      }
      
      override public function replaceItemAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         var _loc3_:DisplayObject = _items.removeChildAt(param2);
         _items.addChildAt(param1,param2);
         realignItems(param2);
         updateScrollBar();
         return _loc3_;
      }
      
      public function realignItems(param1:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc8_:String = P.X;
         var _loc7_:String = P.Y;
         var _loc2_:String = P.W;
         var _loc6_:Rectangle = new Rectangle();
         var _loc5_:int = param1 - 1;
         if(_loc5_ > -1)
         {
            _loc3_ = _items.getChildAt(_loc5_);
            _loc6_[_loc8_] = _loc3_[_loc8_];
            _loc6_[_loc2_] = _loc3_[_loc2_];
         }
         else
         {
            _loc6_[_loc8_] = -itemGap;
            _loc6_[_loc2_] = 0;
         }
         _loc4_ = _items.numChildren;
         while(param1 < _loc4_)
         {
            _loc3_ = _items.getChildAt(param1);
            _loc6_[_loc8_] = itemGap + _loc6_[_loc8_] + _loc6_[_loc2_];
            _loc6_[_loc2_] = _loc3_[_loc2_];
            _loc3_[_loc7_] = 0;
            _loc3_[_loc8_] = _loc6_[_loc8_];
            param1++;
         }
      }
   }
}

class PROFILE#266
{
    
   
   public var V:Boolean = false;
   
   public var X:String;
   
   public var Y:String;
   
   public var W:String;
   
   function PROFILE#266()
   {
      super();
   }
}
