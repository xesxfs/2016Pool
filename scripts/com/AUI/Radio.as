package com.AUI
{
   import com.AUI.event.RadioEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public dynamic class Radio extends Button
   {
      
      private static const listener:EventDispatcher = new EventDispatcher();
      
      public static var incNumber:int = 65536;
       
      
      private var _number:uint = 0;
      
      public function Radio()
      {
         super();
         addEventListener("mouseUp",onClick);
      }
      
      public function get number() : int
      {
         return _number;
      }
      
      public function set number(param1:int) : void
      {
         _number = param1;
         listener.addEventListener("radioChange" + _number,onGroup,false,0,true);
         addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         removeEventListener("removedFromStage",onRemovedFromStage);
         listener.removeEventListener("radioChange" + _number,onGroup);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         checked = true;
      }
      
      protected function onGroup(param1:RadioEvent) : void
      {
         .super.checked = param1.checked == true && param1.value == this;
      }
      
      override public function set checked(param1:Boolean) : void
      {
         var _loc2_:* = null;
         if(super.checked != param1)
         {
            _loc2_ = new RadioEvent("radioChange",true);
            _loc2_.checked = param1;
            _loc2_.value = this;
            dispatchEvent(_loc2_);
            _loc2_ = new RadioEvent("radioChange" + _number);
            _loc2_.checked = param1;
            _loc2_.value = this;
            listener.dispatchEvent(_loc2_);
         }
      }
   }
}
