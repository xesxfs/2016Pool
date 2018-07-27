package fla.play.__rule.player
{
   import fla.play.__rule.IBallGame;
   import flash.events.EventDispatcher;
   
   public class BaseBallPlayer extends EventDispatcher implements IBaseBallPlayer
   {
       
      
      private var __Dm:String;
      
      public function BaseBallPlayer(param1:String)
      {
         super();
         __Dm = param1;
      }
      
      public function __BL(param1:IBallGame) : void
      {
      }
      
      public function get name() : String
      {
         return __Dm;
      }
   }
}
