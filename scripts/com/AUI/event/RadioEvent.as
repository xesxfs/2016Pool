package com.AUI.event
{
   import com.AUI.Radio;
   import flash.events.Event;
   
   public class RadioEvent extends Event
   {
      
      public static const RADIO_CHANGE:String = "radioChange";
       
      
      public var checked:Boolean = false;
      
      public var value:Radio;
      
      public function RadioEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
