package com.AUI
{
   import flash.events.MouseEvent;
   
   public class CloseButton extends Button
   {
       
      
      public function CloseButton()
      {
         super();
         addEventListener(AuiDefine.CLICK,onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         Window(parent).close();
      }
   }
}
