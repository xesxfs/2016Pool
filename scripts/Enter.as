package
{
   import fla.Home;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class Enter extends Sprite
   {
       
      
      public function Enter()
      {
         super();
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         game.self.setContentView(new Home());
      }
   }
}
