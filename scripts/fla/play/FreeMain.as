package fla.play
{
   import fla.Guide;
   import flash.events.Event;
   import fls.SoundEffect;
   
   public class FreeMain extends PlayMain
   {
       
      
      public var _ui:FreeUI;
      
      public var _body:FreeBody;
      
      public function FreeMain()
      {
         super();
         self = this;
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         e = param1;
         super.onAddedToStage(e);
         SoundEffect.init();
         _ui.init();
         _body.init();
         if(_G.player.getFlagAt(0) == false)
         {
            _G.player.setFlag(0,true);
            _ui._countDownPart.pause(true);
            game.hud.addToCenter(new Guide(0,function():void
            {
               _ui._countDownPart.pause(false);
            }));
         }
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         super.onRemovedFromStage(param1);
      }
      
      override public function get body() : PlayBody
      {
         return _body;
      }
      
      override public function get ui() : PlayUI
      {
         return _ui;
      }
      
      override public function getGameMode() : int
      {
         return 0;
      }
      
      override public function getLayout() : Array
      {
         return null;
      }
   }
}
