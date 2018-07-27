package fla.play.__rule
{
   import fla.play.__rule.events.GameEvent;
   import fla.play.__rule.player.BallPlayer;
   import flash.utils.getTimer;
   
   public class BallRule extends BallGame
   {
       
      
      private var m_cLocalPlayer:BallPlayer;
      
      public function BallRule()
      {
         super();
         m_cLocalPlayer = new BallPlayer("LocalPlayer");
      }
      
      public function turnToThisPlayer() : void
      {
         dispatchEvent(new GameEvent("turnGivenTo",m_cLocalPlayer));
      }
      
      public function gameOver(param1:int) : void
      {
         dispatchEvent(new GameEvent("gameOverWinnerIs",m_cLocalPlayer,getTimer() - startTime,param1));
      }
   }
}
