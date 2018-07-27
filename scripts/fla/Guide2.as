package fla
{
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.Window;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class Guide2 extends Window
   {
       
      
      public var _title:TextField;
      
      public var _label:TextField;
      
      public var _done:Button;
      
      public function Guide2(param1:int = 0, param2:Function = null)
      {
         super();
         this.addEventListener("addedToStage",onAddedToStage);
         _title.defaultTextFormat = _G.windowTitle;
         _title.text = Language.id(1037);
         _label.text = Language.id(1035).replace(/\r\n/g,"\n");
         _done.enabled = param1 == 0;
         _done.addEventListener(AuiDefine.CLICK,onClickDone);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.removeEventListener("addedToStage",onAddedToStage);
      }
      
      private function onClickDone(param1:Event) : void
      {
         close();
      }
   }
}
