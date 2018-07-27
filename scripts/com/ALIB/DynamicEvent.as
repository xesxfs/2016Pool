package com.ALIB
{
   import flash.events.Event;
   
   public dynamic class DynamicEvent extends Event
   {
       
      
      public var body;
      
      public function DynamicEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.body = param2;
      }
   }
}
