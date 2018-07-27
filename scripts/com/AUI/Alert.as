package com.AUI
{
   import com.AUI.define.FONT;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Alert extends Window
   {
       
      
      public var _form:MovieClip;
      
      public var _title:TextField;
      
      public var _label:TextField;
      
      public var _done:Button;
      
      public function Alert(param1:String, param2:Function = null, param3:String = null)
      {
         super();
         drag = _form;
         var _loc5_:int = _form.width - _label.width;
         var _loc6_:int = _form.height - _label.height;
         var _loc7_:int = _done.y - (_label.y + _label.height);
         _label.mouseEnabled = false;
         _label.defaultTextFormat = FONT.dialogLabel;
         _label.text = param1.replace(/\r\n/g,"\n");
         _label.width = _label.textWidth + 8;
         _label.height = _label.textHeight + 8;
         var _loc8_:int = _label.width + _loc5_;
         var _loc4_:int = _done.width;
         if(_loc8_ < _loc4_)
         {
            _loc8_ = _loc4_ + _loc5_;
         }
         _form.width = _loc8_;
         _form.height = _label.height + _loc6_;
         if(_title)
         {
            _title.htmlText = param3 || "";
            _title.mouseEnabled = false;
            _title.x = int((_form.width - _title.width) / 2);
         }
         _done.x = int((_form.width - _done.width) / 2);
         _done.y = _label.y + _label.height + _loc7_;
         this.closeHandle = param2;
         _done.addEventListener("mouseUp",onClick);
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         super.onAddedToStage(param1);
         holdKeyBoard = true;
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         super.onRemovedFromStage(param1);
         holdKeyBoard = false;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         close();
      }
      
      override public function ok(param1:MouseEvent) : void
      {
         close();
      }
   }
}
