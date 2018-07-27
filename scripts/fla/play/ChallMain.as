package fla.play
{
   import fla.Guide;
   import flash.events.Event;
   import fls.SoundEffect;
   
   public class ChallMain extends PlayMain
   {
       
      
      public var _ui:ChallUI;
      
      public var _body:ChallBody;
      
      public function ChallMain(param1:Object)
      {
         super();
         PlayMain.self = this;
         this.row = param1;
         param1.record = _G.player.getRecordBy(param1.id,param1.record);
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         super.onAddedToStage(param1);
         SoundEffect.init();
         _ui.init();
         _body.init();
         if(_G.player.getFlagAt(0) == false)
         {
            _G.player.setFlag(0,true);
            game.hud.addToCenter(new Guide());
         }
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         super.onRemovedFromStage(param1);
      }
      
      public function getShots() : int
      {
         return row.shots;
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
         return 1;
      }
      
      override public function getLayout() : Array
      {
         return row.layout.concat();
      }
   }
}
