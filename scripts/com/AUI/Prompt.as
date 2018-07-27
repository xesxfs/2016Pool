package com.AUI
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Prompt extends Window
   {
       
      
      public var _form:MovieClip;
      
      public var _title:TextField;
      
      public var _label:TextField;
      
      public var _done:Button;
      
      public var _undo:Button;
      
      private var _autoScroll:TweenMax;
      
      public function Prompt(param1:String = "", param2:Function = null)
      {
         super();
         drag = _form;
         _label.text = "";
         if(_title)
         {
            _title.htmlText = param1 || "";
            _title.mouseEnabled = false;
         }
         _done.value = "确定";
         _undo.value = "取消";
         this.closeHandle = param2;
         _done.addEventListener("mouseUp",onClick,false,0,true);
         _undo.addEventListener("mouseUp",onClick,false,0,true);
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         var _loc2_:int = 0;
         super.onAddedToStage(param1);
         stage.focus = _label;
         if(_title.textWidth > _title.width)
         {
            _loc2_ = _title.textWidth - _title.width + 4;
            _autoScroll = TweenMax.to(_title,_loc2_ / 60,{
               "delay":1.6,
               "scrollH":-_loc2_,
               "yoyo":true,
               "repeat":2147483647,
               "repeatDelay":3.2
            });
         }
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         super.onRemovedFromStage(param1);
         stage.focus = stage;
         if(_autoScroll)
         {
            _autoScroll.kill();
         }
      }
      
      public function set hideCancel(param1:Boolean) : void
      {
         _done.x = int((_form.width - _done.width) / 2);
         _undo.visible = false;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(param1.target == _done && _label.length == 0)
         {
            stage.focus = _label;
            return;
         }
         closeParams = [param1.target == _done,_label.text];
         close();
      }
      
      override public function ok(param1:MouseEvent) : void
      {
         if(_label.length == 0)
         {
            stage.focus = _label;
            return;
         }
         closeParams = [true,_label.text];
         close();
      }
      
      override public function cancel() : void
      {
         if(_undo.visible == false)
         {
            stage.focus = _label;
            return;
         }
         closeParams = [false,_label.text];
         close();
      }
   }
}
