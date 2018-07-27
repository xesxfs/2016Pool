package com.AUI
{
   import com.AUI.event.DataEvent;
   import flash.events.MouseEvent;
   
   public dynamic class ToggleButton extends Button
   {
       
      
      public function ToggleButton()
      {
         super();
         this.addEventListener("mouseUp",onClick);
      }
      
      override public function set checked(param1:Boolean) : void
      {
         .super.checked = param1;
         var _loc2_:DataEvent = new DataEvent("change",true);
         dispatchEvent(_loc2_);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         this.checked = !this.checked;
      }
   }
}
