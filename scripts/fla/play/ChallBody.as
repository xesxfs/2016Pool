package fla.play
{
   import com.greensock.TweenMax;
   import fla.play.__ball.VisualBall;
   import fla.play.__rule.events.GameEvent;
   import fla.play.__world.PocketEvent;
   import fla.play.effect.NumEffect;
   import flash.events.Event;
   import fls.SoundEffect;
   
   public class ChallBody extends PlayBody
   {
       
      
      private var _errPot:Boolean = false;
      
      public function ChallBody()
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
         (PlayMain.self.ui as ChallUI)._shotPart.decNum();
      }
      
      override protected function onPot(param1:PocketEvent) : void
      {
         e = param1;
         if(e.ball != _rule.lowestBall)
         {
            SoundEffect.playPocket();
            _errPot = true;
            return;
         }
         super.onPot(e);
         var oldLevel:int = _G.player.getLevel();
         var vball:VisualBall = _table.visualBalls[e.ball.number];
         var addScore:int = 10;
         addScore = e.ball.number == 1?1:Number(3 * (e.ball.number - 1));
         _G.player.addScore(addScore);
         PlayMain.self.sumScore = PlayMain.self.sumScore + addScore;
         PlayMain.self.sumLevel = PlayMain.self.sumLevel + (_G.player.getLevel() - oldLevel);
         (PlayMain.self.ui as ChallUI)._scorePart.update();
         var effect:NumEffect = new NumEffect(addScore);
         effect.x = vball.face.x;
         effect.y = vball.face.y;
         PlayMain.self.addChild(effect);
         TweenMax.to(effect,0.4,{
            "alpha":0,
            "delay":0.8
         });
         TweenMax.to(effect,1.2,{
            "y":vball.face.y - 40,
            "onComplete":function():void
            {
               effect.parent.removeChild(effect);
            }
         });
      }
      
      override public function onReplay(param1:Event) : void
      {
         super.onReplay(param1);
         var _loc2_:Object = PlayMain.self.row;
         game.self.setContentView(new ChallMain(_loc2_));
      }
      
      override protected function onTurnTo(param1:GameEvent) : void
      {
         var _loc2_:ChallUI = PlayMain.self.ui as ChallUI;
         if(_errPot == true)
         {
            _rule.gameOver(1);
            return;
         }
         if(_loc2_._shotPart.getNum() == 0)
         {
            _rule.gameOver(2);
            return;
         }
         super.onTurnTo(param1);
         this.shineHalo();
         _loc2_._powerPart.enabled = true;
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
            game.hud.addToCenter(new ChallEnd());
         }
      }
      
      override protected function onShotMiss(param1:Event) : void
      {
         _rule.gameOver(3);
      }
   }
}
