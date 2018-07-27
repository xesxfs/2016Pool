package fla.play
{
   import com.greensock.TweenMax;
   import fla.play.__ball.VisualBall;
   import fla.play.__rule.events.GameEvent;
   import fla.play.__world.PocketEvent;
   import fla.play.effect.NumEffect;
   import flash.events.Event;
   
   public class FreeBody extends PlayBody
   {
       
      
      private var numPot:int = 0;
      
      public function FreeBody()
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
      }
      
      override protected function onShotNotPot(param1:Event) : void
      {
         super.onShotNotPot(param1);
         numPot = 0;
         (PlayMain.self.ui as FreeUI)._comboPart.num = 0;
      }
      
      override protected function onPot(param1:PocketEvent) : void
      {
         e = param1;
         super.onPot(e);
         if(e.ball.number == 0)
         {
            numPot = 0;
            (PlayMain.self.ui as FreeUI)._comboPart.num = 0;
            return;
         }
         numPot = Number(numPot) + 1;
         if(numPot > 1)
         {
            (PlayMain.self.ui as FreeUI)._comboPart.num++;
         }
         var oldLevel:int = _G.player.getLevel();
         var vball:VisualBall = _table.visualBalls[e.ball.number];
         var addScore:int = 10;
         addScore = addScore * (1 + (PlayMain.self.ui as FreeUI)._comboPart.num / 10);
         _G.player.addScore(addScore);
         PlayMain.self.sumScore = PlayMain.self.sumScore + addScore;
         PlayMain.self.sumLevel = PlayMain.self.sumLevel + (_G.player.getLevel() - oldLevel);
         (PlayMain.self.ui as FreeUI)._scorePart.update();
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
         game.self.setContentView(new FreeMain());
      }
      
      override protected function onTurnTo(param1:GameEvent) : void
      {
         super.onTurnTo(param1);
      }
      
      override protected function onGameOver(param1:GameEvent) : void
      {
         super.onGameOver(param1);
         (PlayMain.self.ui as FreeUI)._countDownPart.stop();
         game.hud.addToCenter(new FreeEnd());
      }
   }
}
