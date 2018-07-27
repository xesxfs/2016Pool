package fla.play
{
   import fla.UploadLevel;
   import fla.play.__rule.events.GameEvent;
   import fla.play.__world.PocketEvent;
   import flash.events.Event;
   import fls.SoundEffect;
   
   public class CreateBody extends PlayBody
   {
       
      
      public function CreateBody()
      {
         super();
      }
      
      override public function init() : void
      {
         super.init();
      }
      
      override protected function onShotFin(param1:Event) : void
      {
         super.onShotFin(param1);
         (PlayMain.self.ui as CreateUI)._shotCustomPart.decNum();
      }
      
      override protected function onPot(param1:PocketEvent) : void
      {
         if(param1.ball != _rule.lowestBall)
         {
            SoundEffect.playPocket();
            _rule.gameOver(1);
            return;
         }
         super.onPot(param1);
      }
      
      override public function onReplay(param1:Event) : void
      {
         super.onReplay(param1);
         game.self.setContentView(new CreateMain(CreateMain.mode));
      }
      
      override protected function onTurnTo(param1:GameEvent) : void
      {
         super.onTurnTo(param1);
         var _loc2_:CreateUI = PlayMain.self.ui as CreateUI;
         if(_loc2_._shotCustomPart.getNum() == 0)
         {
            _rule.gameOver(2);
            return;
         }
         if(CreateMain.mode == 1)
         {
            this.shineHalo();
         }
      }
      
      override protected function onGameOver(param1:GameEvent) : void
      {
         var _loc2_:* = null;
         super.onGameOver(param1);
         if(param1.no == 1)
         {
            _loc2_ = Language.id(2100);
            _loc2_ = _loc2_.replace("1",Language.id(2101));
            showSimplePanel(_loc2_);
         }
         else if(param1.no == 2)
         {
            _loc2_ = Language.id(2100);
            _loc2_ = _loc2_.replace("1",Language.id(2102));
            showSimplePanel(_loc2_);
         }
         else if(param1.no == 3)
         {
            _loc2_ = Language.id(2100);
            _loc2_ = _loc2_.replace("1",Language.id(2103));
            showSimplePanel(_loc2_);
         }
         else if(param1.no == 0)
         {
            game.hud.confirm(Language.id(1031),onDoneUpload);
         }
      }
      
      private function onDoneUpload(param1:Boolean) : void
      {
         if(param1 == false)
         {
            return;
         }
         game.hud.addToCenter(new UploadLevel(_G.player.model.createLayout,_G.player.model.createShots,(PlayMain.self.ui as CreateUI)._image));
      }
      
      override protected function onShotMiss(param1:Event) : void
      {
         _rule.gameOver(3);
      }
   }
}
