package com.AUI.event
{
   import flash.events.Event;
   
   public class WindowEvent extends Event
   {
      
      public static const CLOSE_GROUP:String = "closeGroup";
       
      
      public var value;
      
      public function WindowEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
