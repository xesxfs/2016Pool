package com.AUI
{
   import com.AUI.define.FONT;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Confirm extends Window
   {
       
      
      public var _form:MovieClip;
      
      public var _title:TextField;
      
      public var _label:TextField;
      
      public var _done:Button;
      
      public var _undo:Button;
      
      public function Confirm(param1:String, param2:Function = null, param3:String = null)
      {
         super();
         drag = _form;
         var _loc6_:int = _form.width - _label.width;
         var _loc7_:int = _form.height - _label.height;
         var _loc8_:int = _done.y - (_label.y + _label.height);
         _label.mouseEnabled = false;
         _label.defaultTextFormat = FONT.dialogLabel;
         _label.text = param1.replace(/\r\n/g,"\n");
         _label.width = _label.textWidth + 8;
         _label.height = _label.textHeight + 8;
         var _loc9_:int = _label.width + _loc6_;
         var _loc5_:int = _undo.x - _done.x - _done.width;
         var _loc4_:int = _done.width + _undo.width + _loc5_;
         if(_loc9_ < _loc4_)
         {
            _loc9_ = _loc4_ + _loc6_;
         }
         _form.width = _loc9_;
         _form.height = _label.height + _loc7_;
         if(_title)
         {
            _title.htmlText = param3 || "";
            _title.mouseEnabled = false;
            _title.x = int((_form.width - _title.width) / 2);
         }
         _done.x = int((_form.width - _loc4_) / 2);
         _done.y = _label.y + _label.height + _loc8_;
         _undo.x = _done.x + _done.width + _loc5_;
         _undo.y = _done.y;
         this.closeHandle = param2;
         _done.addEventListener("mouseUp",onClick,false,0,true);
         _undo.addEventListener("mouseUp",onClick,false,0,true);
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
         closeParams = [param1.target == _done];
         close();
      }
      
      override public function ok(param1:MouseEvent) : void
      {
         closeParams = [true];
         close();
      }
      
      override public function cancel() : void
      {
         closeParams = [false];
         close();
      }
   }
}
