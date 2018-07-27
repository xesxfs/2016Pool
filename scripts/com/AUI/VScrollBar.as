package com.AUI
{
   public class VScrollBar extends ScrollBar
   {
       
      
      public function VScrollBar()
      {
         super(true);
      }
      
      override public function set height(param1:Number) : void
      {
         var _loc2_:int = param1 - super.height;
         _track.height = _track.height + _loc2_;
         _thumb.height = _thumb.height + _loc2_;
      }
   }
}
