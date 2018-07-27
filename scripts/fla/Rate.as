package fla
{
   import com.ALIB.DynamicEvent;
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.Window;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class Rate extends Window
   {
       
      
      public var _title:TextField;
      
      public var _label:TextField;
      
      public var _done:Button;
      
      public function Rate()
      {
         super();
         _title.text = Language.id(7201);
         _label.text = Language.id(7202);
         _done.addEventListener(AuiDefine.CLICK,onClickDone);
      }
      
      private function onClickDone(param1:Event) : void
      {
         var _loc2_:DynamicEvent = new DynamicEvent("RATE_IT");
         root.dispatchEvent(_loc2_);
         close();
      }
   }
}
