package fla
{
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.Window;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class Guide extends Window
   {
       
      
      public var _title:TextField;
      
      public var _text1:TextField;
      
      public var _text2:TextField;
      
      public var _count:TextField;
      
      public var _done:Button;
      
      private var _seconds:int;
      
      private var _callback:Function;
      
      public function Guide(param1:int = 0, param2:Function = null)
      {
         super();
         this.addEventListener("addedToStage",onAddedToStage);
         _title.defaultTextFormat = _G.windowTitle;
         _title.text = Language.id(7100);
         _text1.text = "① " + Language.id(7101);
         _text2.text = "② " + Language.id(7102);
         _count.text = "";
         _callback = param2;
         _done.enabled = param1 == 0;
         _done.addEventListener(AuiDefine.CLICK,onClickDone);
         _seconds = param1;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         e = param1;
         this.removeEventListener("addedToStage",onAddedToStage);
         if(_seconds)
         {
            _count.text = "(" + _seconds + "s)";
            var tid:int = setInterval(function():void
            {
               _seconds = Number(_seconds) - 1;
               _count.text = "(" + _seconds + "s)";
               if(_seconds == 0)
               {
                  _count.text = "";
                  _done.enabled = true;
                  clearInterval(tid);
               }
            },1000);
         }
      }
      
      private function onClickDone(param1:Event) : void
      {
         if(_callback)
         {
            _callback();
            _callback = null;
         }
      }
   }
}
