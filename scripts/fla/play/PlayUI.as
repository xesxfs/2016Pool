package fla.play
{
   import fla.play.ui.BallBar;
   import fla.play.ui.PowerPart;
   import fla.play.ui.Spin;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PlayUI extends Sprite
   {
       
      
      public var _powerPart:PowerPart;
      
      public var _spin:Spin;
      
      public var _ballBar:BallBar;
      
      public function PlayUI()
      {
         super();
         addEventListener("addedToStage",onAddedToStage);
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
      }
   }
}
