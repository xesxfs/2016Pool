package fla.play.__rule
{
   import fla.play.__CH.Spots;
   import fla.play.__CH.__1_;
   import fla.play.__ball.LogicalBall;
   import fla.play.__layout.BallLayout;
   import fla.play.__layout.IBallLayout;
   import fla.play.__rule.events.GameEvent;
   import fla.play.__world.World;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   
   public class BallGame extends EventDispatcher implements IBallGame
   {
      
      public static const NEW_GAME:String = "newGame";
       
      
      protected var startTime:Number;
      
      protected var _world:World;
      
      public function BallGame()
      {
         super();
         _world = new World(newSpots(),newBallLayout());
         _world.addEventListener("animationDone",onAniFinish);
      }
      
      protected function __M() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = world.balls;
         for each(_loc1_ in world.balls)
         {
            _loc1_.setState = 0;
            _loc1_.reset();
            _loc1_.position.init(0,0);
         }
      }
      
      public function rackUp() : void
      {
         world.ballProperties.rackUp();
         dispatchEvent(new GameEvent("rackup",undefined));
      }
      
      protected function newBallLayout() : IBallLayout
      {
         return new BallLayout();
      }
      
      protected function __2A(param1:Array) : void
      {
         var _loc6_:* = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = uint(_loc5_ + 1);
            while(_loc6_ < param1.length)
            {
               _loc2_ = param1[_loc5_].x - param1[_loc6_].x;
               _loc3_ = param1[_loc5_].y - param1[_loc6_].y;
               _loc4_ = Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
               if(_loc4_ <= 3)
               {
                  trace("warning! distance between" + _loc5_ + " and " + _loc6_ + " = " + _loc4_);
               }
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      public function init(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         world.__H(param1,param2,param3,param4);
      }
      
      protected function newSpots() : __1_
      {
         return new Spots();
      }
      
      protected function debugMessage(param1:String) : void
      {
      }
      
      public function get world() : World
      {
         return _world;
      }
      
      protected function onAniFinish(param1:Event) : void
      {
      }
      
      public function newGame() : void
      {
         __M();
         startTime = getTimer();
         dispatchEvent(new Event("newGame"));
      }
   }
}
