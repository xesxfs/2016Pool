package com.AUI.event
{
   import flash.events.Event;
   
   public class ItemEvent extends Event
   {
      
      public static const ITEM_SELECT:String = "itemSelect";
      
      public static const ITEM_CLICK:String = "itemClick";
      
      public static const ITEM_ADD:String = "itemAdd";
      
      public static const ITEM_DEL:String = "itemDel";
       
      
      public var index:int;
      
      public var value;
      
      public function ItemEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc1_:ItemEvent = new ItemEvent(type,bubbles,cancelable);
         _loc1_.index = index;
         _loc1_.value = value;
         return _loc1_;
      }
   }
}
