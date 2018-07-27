package fla.play.__rule.events
{
   import fla.play.__rule.player.IBaseBallPlayer;
   import flash.events.Event;
   
   public class GameEvent extends Event
   {
      
      public static const TIME_OUT:String = "turnTimerTimedOut";
      
      public static const GAME_OVER:String = "gameOverWinnerIs";
      
      public static const STOP:String = "turnTimerStopped";
      
      public static const RACK_UP:String = "rackup";
      
      public static const SET_TO:String = "turnSetTo";
      
      public static const TURN_TO:String = "turnGivenTo";
       
      
      public var player:IBaseBallPlayer;
      
      public var duration:Number;
      
      public var no:int;
      
      public function GameEvent(param1:String, param2:IBaseBallPlayer, param3:Number = 0, param4:int = 0)
      {
         super(param1);
         this.player = param2;
         this.duration = param3;
         this.no = param4;
      }
   }
}
