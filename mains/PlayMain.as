package fla.play
{
   import com.ALIB.DynamicEvent;
   import com.AUI.Window;
   import com.greensock.TweenMax;
   import fla.play.__tween.__Timer;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PlayMain extends Window
   {
      
      public static var self:PlayMain;
       
      
      public var _bg:Sprite;
      
      public var row:Object;
      
      public var sumScore:int = 0;
      
      public var sumLevel:int = 0;
      
      public function PlayMain()
      {
         super();
         addEventListener("addedToStage",onAddedToStage);
      }
      
      public function get body() : PlayBody
      {
         return null;
      }
      
      public function get ui() : PlayUI
      {
         return null;
      }
      
      public function getLayout() : Array
      {
         return null;
      }
      
      public function getGameMode() : int
      {
         return 0;
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         super.onAddedToStage(param1);
         var _loc2_:DynamicEvent = new DynamicEvent("CHANGE_BG");
         _loc2_.body = _bg;
         root.dispatchEvent(_loc2_);
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         super.onRemovedFromStage(param1);
         TweenMax.killAll(true);
         __Timer.killAll();
      }
   }
}
