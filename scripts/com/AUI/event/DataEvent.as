package com.AUI.event
{
   import flash.events.Event;
   
   public class DataEvent extends Event
   {
      
      public static const DATA_CHANGE:String = "dataChange";
       
      
      public var value;
      
      public function DataEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
