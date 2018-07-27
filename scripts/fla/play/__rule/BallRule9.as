package fla.play.__rule
{
   import fla.play.PlayMain;
   import fla.play.__CH.ISpots;
   import fla.play.__ball.LogicalBall;
   import fla.play.__layout.BallLayout9;
   import fla.play.__layout.IBallLayout;
   import fla.play.__locale.BallLocale2;
   import fla.play.__locale.__Fn;
   import fla.play.__tween.__45;
   import fla.play.__world.CollisionEvent;
   import fla.play.__world.IShotResultArray;
   import fla.play.__world.PocketEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class BallRule9 extends BallRule
   {
      
      public static const GAME_OVER:int = 1;
      
      public static const GAME_LAST_BALL:int = 4;
      
      public static const GMAE_RESET:int = 2;
      
      public static const GAMING:int = 3;
      
      private static const START_TIME:Number = 300000;
      
      private static const TIME_BETWEEN_RACK_COUNT:Number = 200;
       
      
      private var __6Y:Number;
      
      private var __8j:Number;
      
      private var __Bj:Number;
      
      private var __GS:Number;
      
      private var __49:Boolean;
      
      private var __5c:Number;
      
      private var _lowestBall:LogicalBall;
      
      private var __0o:Number;
      
      private var __3T:Number;
      
      private var _state:int;
      
      private var __BI:Number;
      
      private var __67:Number;
      
      private var __GY:Boolean;
      
      private var __Eu:Array;
      
      private var __2e:__45;
      
      private var __AO:Number;
      
      private var __9R:Number;
      
      public function BallRule9()
      {
         __Eu = [];
         __2e = new __45();
         super();
         _world.addEventListener("ballEnteredPocket",onPot,false,-1);
         _world.addEventListener("tableBallBallCollision",onBallBallCollision);
         _world.addEventListener("shotFin",onShotFin);
         _state = 1;
      }
      
      public function isInGame() : Boolean
      {
         return _state != 1;
      }
      
      override protected function onAniFinish(param1:Event) : void
      {
         if(_state == 1)
         {
            return;
         }
         _state = 3;
         var _loc4_:IShotResultArray = _world.shotResults;
         var _loc7_:LogicalBall = world.cueBall;
         var _loc8_:Boolean = _loc4_.indexOf(_loc7_);
         if(world.ballsOnTable == 0 || world.ballsOnTable == 1 && _loc8_ == false)
         {
            this.gameOver(0);
            return;
         }
         world.respotBounds = null;
         var _loc6_:Boolean = isOrderCollisioning();
         var _loc2_:Boolean = _loc6_ && (_loc4_.__Gg.length > 0 || _loc4_.cushionCollisions.length > 0 && __G2().time > __EU().time);
         var _loc3_:Boolean = !_loc6_ || !_loc2_ || _loc8_ && state == 3;
         if(_loc3_)
         {
            __Bj = Number(__Bj) + 1;
            __49 = true;
         }
         if(_loc8_)
         {
            world.respotBall(world.cueBall,0,0,3);
         }
         if(isCollision() == false)
         {
            world.dispatchEvent(new Event("shotMiss"));
         }
         if(_loc4_.numBalls == 0)
         {
            world.dispatchEvent(new Event("shotNotPot"));
         }
         _lowestBall = findLowestBall();
         turnToThisPlayer();
      }
      
      private function __G2() : BallLocale2
      {
         return world.shotResults.cushionCollisions.length > 0?world.shotResults.cushionCollisions[world.shotResults.cushionCollisions.length - 1] as BallLocale2:null;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      override public function turnToThisPlayer() : void
      {
         if(_state == 1)
         {
            return;
         }
         __8j = getTimer();
         super.turnToThisPlayer();
      }
      
      public function get __AJ() : Number
      {
         return __3T;
      }
      
      public function get paused() : Boolean
      {
         return __GY;
      }
      
      private function onShotFin(param1:Event) : void
      {
         __0o = __0o + (getTimer() - __8j);
         __5c = Number(__5c) + 1;
      }
      
      public function get __Gq() : Number
      {
         return __AO;
      }
      
      override public function newGame() : void
      {
         super.newGame();
         reset();
         __8j = getTimer();
         __2e.value = __8j;
         rackUp();
         _state = 2;
         turnToThisPlayer();
         PlayMain.self.addEventListener("enterFrame",onEnterFrame,false,0,true);
      }
      
      private function onBallBallCollision(param1:CollisionEvent) : void
      {
         var _loc4_:Number = NaN;
         if(_state != 3 && _state != 2)
         {
            return;
         }
         var _loc3_:__Fn = param1.array[0] as __Fn;
         if(_loc3_.ballCollided(world.cueBall) && world.shotResults.ballCollisions.length == param1.array.length && isOrderCollisioning())
         {
            __AO = Number(__AO) + 1;
         }
      }
      
      override public function rackUp() : void
      {
         var _loc2_:Number = NaN;
         super.rackUp();
         var _loc1_:ISpots = world.tableProperties as ISpots;
         world.respotBounds = new Rectangle(-_loc1_.length / 2,-_loc1_.width / 2,_loc1_.length,_loc1_.width);
         __49 = false;
         if(!isNaN(__6Y))
         {
            _loc2_ = getTimer() - __6Y;
            if(isNaN(__3T))
            {
               __3T = _loc2_;
            }
            else
            {
               __3T = Math.min(__3T,_loc2_);
            }
         }
         __6Y = getTimer();
         _lowestBall = findLowestBall();
      }
      
      override protected function newBallLayout() : IBallLayout
      {
         return new BallLayout9();
      }
      
      public function get __Fg() : Number
      {
         return __0o;
      }
      
      public function reset() : void
      {
         var _loc1_:* = null;
         _state = 1;
         __Eu.length = 0;
         __5c = 0;
         __AO = 0;
         __Bj = 0;
         __GS = 0;
         __9R = 0;
         __0o = 0;
         __6Y = NaN;
         __3T = NaN;
         var _loc3_:int = 0;
         var _loc2_:* = world.balls;
         for each(_loc1_ in world.balls)
         {
            _loc1_.setState = 0;
         }
      }
      
      public function get lowestBall() : LogicalBall
      {
         return _lowestBall;
      }
      
      public function get __Dy() : Number
      {
         return __Bj;
      }
      
      public function get __6N() : Number
      {
         return __9R;
      }
      
      public function set paused(param1:Boolean) : void
      {
         var _loc2_:Number = NaN;
         if(__GY == param1)
         {
            return;
         }
         __GY = param1;
         _world.paused = __GY;
         if(__GY)
         {
            __67 = getTimer();
         }
         else
         {
            _loc2_ = getTimer() - __67;
            __8j = __8j + _loc2_;
            __2e.value = __2e.value + _loc2_;
         }
      }
      
      public function get __Gf() : Number
      {
         return __GS;
      }
      
      private function isCollision() : Boolean
      {
         return world.shotResults.ballCollisions.length != 0;
      }
      
      private function isOrderCollisioning() : Boolean
      {
         return !world.shotResults.ballCollisions.length == 0 && __EU().ballCollided(_lowestBall);
      }
      
      private function onPot(param1:PocketEvent) : void
      {
         _lowestBall = findLowestBall();
      }
      
      public function get __Gh() : Number
      {
         return __5c;
      }
      
      public function updateLowestBall() : void
      {
         this._lowestBall = findLowestBall();
      }
      
      public function findLowestBall() : LogicalBall
      {
         var _loc1_:int = 1;
         while(_loc1_ < world.balls.length)
         {
            if((world.balls[_loc1_] as LogicalBall).state == 1)
            {
               return world.balls[_loc1_] as LogicalBall;
            }
            _loc1_++;
         }
         return null;
      }
      
      private function __EU() : __Fn
      {
         return world.shotResults.ballCollisions.length > 0?world.shotResults.ballCollisions[0] as __Fn:null;
      }
      
      public function get __88() : Number
      {
         var _loc1_:Number = !!__GY?__67:getTimer();
         return 300000 - (_loc1_ - __2e.value);
      }
      
      override public function gameOver(param1:int) : void
      {
         if(_state == 1)
         {
            return;
         }
         super.gameOver(param1);
         _state = 1;
         PlayMain.self.removeEventListener("enterFrame",onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(_state == 1 || __GY)
         {
            return;
         }
      }
   }
}
