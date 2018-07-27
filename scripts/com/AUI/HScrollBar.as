package com.AUI
{
   public class HScrollBar extends ScrollBar
   {
       
      
      public function HScrollBar()
      {
         super(false);
      }
      
      override public function set width(param1:Number) : void
      {
         var _loc2_:int = param1 - super.width;
         _track.width = _track.width + _loc2_;
         _thumb.width = _thumb.width + _loc2_;
      }
   }
}
