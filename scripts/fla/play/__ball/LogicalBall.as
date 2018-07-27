package fla.play.__ball
{
   import fla.play.__EW.Coord;
   import fla.play.__EW.__7O;
   import fla.play.__EW.__FL;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class LogicalBall extends EventDispatcher
   {
      
      public static const POCKET:uint = 4;
      
      public static const __04:uint = 0;
      
      private static const __AR:Number = 1.667;
      
      public static const __3t:uint = 3;
      
      public static const __GG:int = -2;
      
      public static const HIT_POCKET:uint = 2;
      
      public static const STATE_CHANGED:String = "ballMovableStateChanged";
      
      public static const __BP:int = -1;
      
      public static const nSTATE_IN_PLAY:uint = 1;
      
      public static const BALL_UPDATED:String = "ballUpdated";
       
      
      private var _number:Number;
      
      public var rotation:__FL;
      
      public var radius:Number;
      
      public var state:Number;
      
      private var __7X:Number;
      
      private var __EE:__7O;
      
      private var __Gk:__FL;
      
      private var __34:int;
      
      public var velocity:Coord;
      
      public var position:Coord;
      
      private var m_cSpin:__7O;
      
      private var __HF:Number;
      
      public var _update:Boolean;
      
      private var __Db:Boolean;
      
      public function LogicalBall(param1:Number, param2:Number, param3:int = -1, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:Number = 0)
      {
         position = new Coord();
         velocity = new Coord();
         rotation = new __FL();
         m_cSpin = new __7O();
         __Gk = new __FL();
         __EE = new __7O();
         super();
         _number = param1;
         __34 = param3;
         radius = param2;
         __7X = 1.33333333333333 * 3.14159265358979 * Math.pow(radius,3);
         __HF = __7X * 1.667;
         position.x = param4;
         position.y = param5;
         velocity.x = param6;
         velocity.y = param7;
         rotation.__50();
         __Db = false;
         _update = true;
         state = 0;
      }
      
      public function get onTable() : Boolean
      {
         return state == 1 || state == 2;
      }
      
      public function updateVisualBall() : void
      {
         if(_update)
         {
            dispatchEvent(new Event("ballUpdated"));
            _update = false;
         }
      }
      
      public function set setState(param1:uint) : void
      {
         if(param1 == state)
         {
            return;
         }
         dispatchEvent(new BallEvent("ballChangedState",state,param1));
         state = param1;
      }
      
      public function get number() : Number
      {
         return _number;
      }
      
      public function move(param1:Number) : void
      {
         position.x = position.x + velocity.x * param1;
         position.y = position.y + velocity.y * param1;
         _update = true;
      }
      
      public function __Du() : Boolean
      {
         return velocity.x != 0 || velocity.y != 0;
      }
      
      public function setPosition(param1:Number, param2:Number) : void
      {
         reset();
         setState = 1;
         position.x = param1;
         position.y = param2;
         _update = true;
         updateVisualBall();
      }
      
      public function set movable(param1:Boolean) : void
      {
         if(__Db == param1)
         {
            return;
         }
         __Db = param1;
         dispatchEvent(new Event("ballMovableStateChanged"));
      }
      
      public function get classification() : int
      {
         return __34;
      }
      
      public function get movable() : Boolean
      {
         return __Db;
      }
      
      public function get spin() : __7O
      {
         return m_cSpin;
      }
      
      public function isMovingOrSpinning() : Boolean
      {
         return velocity.x != 0 || velocity.y != 0 || spin.x != 0 || spin.y != 0 || spin.z != 0;
      }
      
      public function reset() : void
      {
         velocity.x = 0;
         velocity.y = 0;
         spin.x = 0;
         spin.y = 0;
         spin.z = 0;
      }
      
      public function get __Cb() : Number
      {
         return __HF;
      }
      
      public function __AM(param1:Number) : void
      {
         if(spin.x == 0 && spin.y == 0 && spin.z == 0)
         {
            return;
         }
         __EE.__Fl(m_cSpin);
         var _loc2_:Number = __EE.length * param1;
         __EE.__Dz();
         __Gk.__CG(__EE,_loc2_);
         rotation.__0J(__Gk);
      }
   }
}
