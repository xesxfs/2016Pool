package fla.play.__world
{
   import fla.play.__1D.__6o;
   import fla.play.__CH.__1_;
   import fla.play.__ball.LogicalBall;
   import fla.play.__ball.Table#214;
   import fla.play.__layout.IBallLayout;
   import fla.play.__locale.BallLocale;
   import fla.play.__locale.BallLocale2;
   import fla.play.__locale.BallLocale3;
   import fla.play.__locale.__BV;
   import fla.play.__locale.__Fn;
   import fla.play.__tween.__Timer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class World extends EventDispatcher
   {
      
      public static const __9e:uint = 2;
      
      private static const __EF:Number = 120.0;
      
      public static const __Bm:uint = 0;
      
      public static const ANI_FIN:String = "animationDone";
      
      public static const __B4:uint = 3;
      
      private static const __47:Number = 2;
      
      public static const __4j:uint = 1;
      
      private static const TIME_SCALE:Number = 1;
      
      public static const __2W:uint = 4;
      
      private static const __2U:Number = 2.5;
       
      
      private var _repotBounds:Rectangle = null;
      
      private var __GY:Boolean;
      
      public var _timer:__Timer;
      
      private var _balls:Vector.<LogicalBall>;
      
      private var __9p:CollisionEvent;
      
      private var _shotResultArray:ShotResultArray;
      
      private var __7d:__1_;
      
      private var __FF:Rectangle = null;
      
      private var __8Q:IBallLayout;
      
      private var __DJ:Array;
      
      private var __1S:CollisionEvent;
      
      public function World(param1:__1_, param2:IBallLayout)
      {
         __DJ = [];
         __1S = new CollisionEvent("tableBallBallCollision");
         __9p = new CollisionEvent("tableBallCushionCollision");
         _shotResultArray = new ShotResultArray();
         super();
         __7d = param1;
         __8Q = param2;
         _balls = param2.balls;
         _timer = new __Timer(__3c,render,2);
         var _loc3_:* = 0;
         while(_loc3_ < param1.__H1.length)
         {
            __DJ.push(new Point(param1.__H1[_loc3_].x - param1.length / 2,param1.__H1[_loc3_].y - param1.width / 2));
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.__FC.length)
         {
            __DJ.push(new Point(param1.__FC[_loc3_].x,param1.__FC[_loc3_].y - param1.width / 2));
            _loc3_++;
         }
         _loc3_ = param1.__H1.length - 1;
         while(_loc3_ >= 0)
         {
            __DJ.push(new Point(-param1.__H1[_loc3_].x + param1.length / 2,param1.__H1[_loc3_].y - param1.width / 2));
            _loc3_--;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.__H1.length)
         {
            __DJ.push(new Point(-param1.__H1[_loc3_].x + param1.length / 2,-param1.__H1[_loc3_].y + param1.width / 2));
            _loc3_++;
         }
         _loc3_ = param1.__FC.length - 1;
         while(_loc3_ >= 0)
         {
            __DJ.push(new Point(param1.__FC[_loc3_].x,-param1.__FC[_loc3_].y + param1.width / 2));
            _loc3_--;
         }
         _loc3_ = param1.__H1.length - 1;
         while(_loc3_ >= 0)
         {
            __DJ.push(new Point(param1.__H1[_loc3_].x - param1.length / 2,-param1.__H1[_loc3_].y + param1.width / 2));
            _loc3_--;
         }
         __FF = new Rectangle(-param1.length / 2,-param1.width / 2,param1.length,param1.width);
         _repotBounds = __FF;
      }
      
      private function render() : void
      {
         if(__GY)
         {
            return;
         }
         Table#214.instance.renderBalls();
         dispatchEvents();
      }
      
      public function respotBall(param1:LogicalBall, param2:Number, param3:Number, param4:uint = 0) : void
      {
         var _loc5_:* = undefined;
         var _loc13_:LogicalBall = null;
         var _loc12_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc10_:* = null;
         var _loc11_:* = _repotBounds != null?_repotBounds:__FF;
         param2 = Math.max(_loc11_.left + param1.radius + 1.0e-11,Math.min(_loc11_.right - param1.radius - 1.0e-11,param2));
         param3 = Math.max(_loc11_.top + param1.radius + 1.0e-11,Math.min(_loc11_.bottom - param1.radius - 1.0e-11,param3));
         param1.setPosition(param2,param3);
         var _loc6_:Vector.<LogicalBall> = _balls;
         var _loc16_:int = 0;
         var _loc15_:* = _loc6_;
         for each(_loc13_ in _loc6_)
         {
            if(param1 != _loc13_ && Math.sqrt(__6z(param1.position.x,param1.position.y,_loc13_.position.x,_loc13_.position.y)) <= _loc13_.radius + param1.radius)
            {
               _loc5_ = param4;
               var _loc14_:* = _loc5_;
               if(0 !== _loc14_)
               {
                  if(2 !== _loc14_)
                  {
                     if(1 !== _loc14_)
                     {
                        if(1 !== _loc14_)
                        {
                           if(3 !== _loc14_)
                           {
                              trace("Warning! could not respot ball " + param1.number + " at (" + param2 + "," + param3 + ") because ball " + _loc13_.number + " is occupying this space");
                           }
                           else
                           {
                              _loc10_ = __Ev(param1);
                              respotBall(param1,_loc10_.x,_loc10_.y,4);
                           }
                        }
                        continue;
                     }
                  }
                  _loc12_ = _loc13_.position.y - param3;
                  _loc8_ = param1.radius + _loc13_.radius;
                  _loc7_ = Math.sqrt(_loc8_ * _loc8_ - _loc12_ * _loc12_) + 1.0e-11;
                  if(param4 == 2 || _loc13_.position.x + _loc7_ + param1.radius > _loc11_.x + _loc11_.width)
                  {
                     respotBall(param1,_loc13_.position.x - _loc7_,param3,2);
                  }
                  else
                  {
                     respotBall(param1,_loc13_.position.x + _loc7_,param3,1);
                  }
               }
               else
               {
                  respotBall(_loc13_,0,0,1);
               }
            }
         }
      }
      
      private function __6z(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:* = param1 - param3;
         var _loc6_:* = param2 - param4;
         return _loc5_ * _loc5_ + _loc6_ * _loc6_;
      }
      
      public function __Ft() : void
      {
         _timer.start();
      }
      
      private function __z(param1:BallLocale) : void
      {
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc4_:Number = NaN;
         param1.time = param1.time + getTimer();
         if(param1 is __Fn)
         {
            _loc5_ = (param1 as __Fn).ballA;
            _loc7_ = (param1 as __Fn).ballB;
            __6o.ballBallCollision(_loc5_,_loc7_);
            _shotResultArray.ballBallCollision(param1 as __Fn);
            __1S.array.push(param1);
         }
         else if(param1 is BallLocale3)
         {
            __6o.ballLineCollision((param1 as BallLocale3).ball,(param1 as BallLocale3).__96);
            if((param1 as BallLocale3).ball.state == 1)
            {
               _shotResultArray.ballCushionCollision(param1 as BallLocale2);
            }
            __9p.array.push(param1);
         }
         else if(param1 is __BV)
         {
            _loc6_ = param1 as __BV;
            _loc3_ = _loc6_.point.x - _loc6_.ball.position.x;
            _loc2_ = _loc6_.point.y - _loc6_.ball.position.y;
            _loc4_ = -__6o.__Cn(_loc2_,-_loc3_);
            __6o.ballLineCollision(_loc6_.ball,_loc4_);
            _shotResultArray.ballCushionCollision(_loc6_ as BallLocale2);
            __9p.array.push(param1);
         }
      }
      
      public function findFirstCollisionBall(param1:LogicalBall, param2:Number) : BallLocale
      {
         var _loc10_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc8_:* = 0;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc9_:* = null;
         if(param1.state == 1)
         {
            _loc8_ = param1.number + 1;
            while(_loc8_ < _balls.length)
            {
               if(_balls[_loc8_].state == 1)
               {
                  _loc6_ = __6o.ballBallCollisionTime(param1,_balls[_loc8_],param2);
                  if(__6o.ballBallCollisionTime(param1,_balls[_loc8_],param2) < param2)
                  {
                     _loc5_ = param1.velocity.x - _balls[_loc8_].velocity.x;
                     _loc4_ = param1.velocity.y - _balls[_loc8_].velocity.y;
                     _loc9_ = new __Fn(param1,_balls[_loc8_],_loc6_,Math.sqrt(_loc5_ * _loc5_ + _loc4_ * _loc4_));
                     param2 = _loc6_;
                  }
               }
               _loc8_++;
            }
         }
         if(param1.velocity.x > 0)
         {
            _loc10_ = param1.position.x;
            _loc11_ = _loc10_ + param1.velocity.x * param2;
         }
         else
         {
            _loc11_ = param1.position.x;
            _loc10_ = param1.position.x + param1.velocity.x * param2;
         }
         if(param1.velocity.y > 0)
         {
            _loc12_ = param1.position.y;
            _loc7_ = param1.position.y + param1.velocity.y * param2;
         }
         else
         {
            _loc7_ = param1.position.y;
            _loc12_ = param1.position.y + param1.velocity.y * param2;
         }
         if(_loc10_ < __FF.left + param1.radius || _loc11_ > __FF.right - param1.radius || _loc12_ < __FF.top + param1.radius || _loc7_ > __FF.bottom - param1.radius)
         {
            if(param1.state == 1 && param1.classification != -2)
            {
               _loc8_ = 0;
               while(_loc8_ < __7d.__6p.length)
               {
                  _loc3_ = __7d.__6p[_loc8_].x - param1.position.x;
                  _loc13_ = __7d.__6p[_loc8_].y - param1.position.y;
                  _loc14_ = Math.sqrt(_loc3_ * _loc3_ + _loc13_ * _loc13_);
                  if(Math.sqrt(_loc3_ * _loc3_ + _loc13_ * _loc13_) < __7d.__1d)
                  {
                     param1.velocity.add(_loc3_ * 120 * param2,_loc13_ * 120 * param2);
                     if(_loc14_ < param1.radius)
                     {
                        param1.setState = 2;
                        dispatchEvent(new PocketEvent("ballEnteredPocket",param1));
                     }
                  }
                  _loc8_++;
               }
            }
            else if(param1.state == 2)
            {
               param1.velocity.add(-param1.position.x * 2.5 * param2,-param1.position.y * 2.5 * param2);
            }
            _loc8_ = 0;
            while(_loc8_ < __DJ.length)
            {
               _loc15_ = __DJ[_loc8_];
               _loc16_ = __DJ[(_loc8_ + 1) % __DJ.length];
               _loc6_ = __6o.ballLineCollisionTime(param1,_loc15_,_loc16_,param2);
               if(__6o.ballLineCollisionTime(param1,_loc15_,_loc16_,param2) < param2)
               {
                  _loc9_ = new BallLocale3(param1,-__6o.__Cn(_loc16_.x - _loc15_.x,_loc16_.y - _loc15_.y),_loc6_,param1.velocity.length);
                  param2 = _loc6_;
               }
               _loc6_ = __6o.ballPointCollisionTime(param1,_loc15_,param2);
               if(__6o.ballPointCollisionTime(param1,_loc15_,param2) < param2)
               {
                  _loc9_ = new __BV(param1,_loc15_,_loc6_,param1.velocity.length);
                  param2 = _loc6_;
               }
               _loc8_++;
            }
         }
         else if(param1.state == 2)
         {
            param1.setState = 3;
            param1.reset();
            param1.setState = 4;
            param1.updateVisualBall();
            _shotResultArray.ballPocketed(param1);
         }
         return _loc9_;
      }
      
      public function dispatchEvents() : void
      {
         if(__1S.array.length > 0)
         {
            dispatchEvent(__1S);
            __1S = new CollisionEvent("tableBallBallCollision");
         }
         if(__9p.array.length > 0)
         {
            dispatchEvent(__9p);
            __9p = new CollisionEvent("tableBallCushionCollision");
         }
      }
      
      public function __4h(param1:Number) : Boolean
      {
         var _loc2_:* = null;
         var _loc6_:Number = NaN;
         var _loc4_:BallLocale = null;
         var _loc3_:int = 0;
         var _loc5_:* = false;
         var _loc7_:* = param1;
         while(_loc7_ > 1.0e-11)
         {
            _loc6_ = _loc7_;
            _loc4_ = __E7(_loc6_);
            if(_loc4_ != null)
            {
               _loc6_ = _loc4_.time;
            }
            _loc3_ = 0;
            while(_loc3_ < _balls.length)
            {
               _loc2_ = _balls[_loc3_];
               if(_loc2_.isMovingOrSpinning() && _loc2_.state == 1 || _loc2_.state == 2)
               {
                  _loc2_.move(_loc6_);
                  _loc5_ = true;
               }
               _loc3_++;
            }
            if(_loc4_ != null)
            {
               __z(_loc4_);
            }
            _loc7_ = _loc7_ - _loc6_;
         }
         _loc5_ = __2b(param1) || _loc5_;
         return _loc5_;
      }
      
      public function get respotBounds() : Rectangle
      {
         return _repotBounds;
      }
      
      private function __3c(param1:Number) : void
      {
         if(__GY)
         {
            return;
         }
         if(!__4h(param1) && _timer.running)
         {
            _timer.stop();
            dispatchEvent(new Event("animationDone"));
         }
      }
      
      public function get ballsOnTable() : uint
      {
         var _loc4_:LogicalBall = null;
         var _loc2_:int = 0;
         var _loc1_:Vector.<LogicalBall> = _balls;
         var _loc6_:int = 0;
         var _loc5_:* = _loc1_;
         for each(_loc4_ in _loc1_)
         {
            if(_loc4_.state == 1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function set respotBounds(param1:Rectangle) : void
      {
         _repotBounds = param1;
      }
      
      public function get ballProperties() : IBallLayout
      {
         return __8Q;
      }
      
      public function __Ev(param1:LogicalBall) : Point
      {
         var _loc16_:* = null;
         var _loc19_:LogicalBall = null;
         var _loc18_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:* = null;
         var _loc12_:* = 0;
         var _loc5_:* = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc24_:* = null;
         var _loc23_:* = null;
         var _loc20_:* = new Point();
         var _loc22_:* = Infinity;
         var _loc21_:* = [];
         var _loc17_:int = 0;
         while(_loc17_ < _balls.length)
         {
            _loc19_ = _balls[_loc17_];
            if(param1 != _loc19_ && _loc19_.state == 1)
            {
               _loc18_ = param1.radius + _loc19_.radius + 1.0e-11;
               _loc15_ = (_loc19_.radius + param1.radius) * (_loc19_.radius + param1.radius) + 1.0e-11;
               _loc14_ = _loc19_.position.x - param1.position.x;
               _loc13_ = _loc19_.position.y - param1.position.y;
               _loc9_ = Math.sqrt(_loc14_ * _loc14_ + _loc13_ * _loc13_);
               _loc10_ = Math.sqrt(_loc14_ * _loc14_ + _loc13_ * _loc13_) - (_loc18_ + 1.0e-11);
               _loc21_.push(new Point(param1.position.x + _loc14_ * _loc10_ / _loc9_,param1.position.y + _loc13_ * _loc10_ / _loc9_));
               _loc11_ = _repotBounds != null?_repotBounds:__FF;
               __6o.__4z(_loc11_.left + param1.radius,_loc19_.position.x,_loc19_.position.y,_loc18_,_loc21_);
               __6o.__4z(_loc11_.right - param1.radius,_loc19_.position.x,_loc19_.position.y,_loc18_,_loc21_);
               __6o.__8H(_loc11_.top + param1.radius,_loc19_.position.x,_loc19_.position.y,_loc18_,_loc21_);
               __6o.__8H(_loc11_.bottom - param1.radius,_loc19_.position.x,_loc19_.position.y,_loc18_,_loc21_);
               _loc12_ = _loc17_;
               while(_loc12_ < _balls.length)
               {
                  _loc5_ = _balls[_loc12_];
                  if(param1 != _loc5_ && Math.sqrt(__6z(_loc19_.position.x,_loc5_.position.y,_loc19_.position.x,_loc5_.position.y)) <= (_loc19_.radius + param1.radius) * 2)
                  {
                     _loc6_ = (_loc5_.radius + param1.radius) * (_loc5_.radius + param1.radius);
                     _loc7_ = _loc5_.position.x - _loc19_.position.x;
                     _loc8_ = _loc5_.position.y - _loc19_.position.y;
                     _loc4_ = _loc7_ * _loc7_ + _loc8_ * _loc8_;
                     _loc3_ = Math.sqrt(_loc4_);
                     _loc2_ = (_loc4_ + _loc15_ - _loc6_) / (2 * _loc3_);
                     _loc26_ = _loc2_ * _loc2_;
                     _loc25_ = Math.sqrt(_loc15_ - _loc26_) + 1.0e-11;
                     _loc24_ = new Point(_loc19_.position.x + _loc7_ * _loc2_ / _loc3_ + _loc8_ / _loc3_ * _loc25_,_loc19_.position.y + _loc8_ * _loc2_ / _loc3_ - _loc7_ / _loc3_ * _loc25_);
                     _loc23_ = new Point(_loc19_.position.x + _loc7_ * _loc2_ / _loc3_ - _loc8_ / _loc3_ * _loc25_,_loc19_.position.y + _loc8_ * _loc2_ / _loc3_ + _loc7_ / _loc3_ * _loc25_);
                     _loc21_.push(_loc24_);
                     _loc21_.push(_loc23_);
                  }
                  _loc12_++;
               }
            }
            _loc17_++;
         }
         var _loc27_:* = _loc21_;
         var _loc30_:int = 0;
         var _loc29_:* = _loc27_;
         for each(_loc16_ in _loc27_)
         {
            _loc3_ = Math.sqrt(__6z(param1.position.x,param1.position.y,_loc16_.x,_loc16_.y));
            if(Math.sqrt(__6z(param1.position.x,param1.position.y,_loc16_.x,_loc16_.y)) < _loc22_ && __Gs(param1,_loc16_))
            {
               _loc20_ = _loc16_;
               _loc22_ = _loc3_;
            }
         }
         return _loc20_;
      }
      
      public function get balls() : Vector.<LogicalBall>
      {
         return _balls;
      }
      
      public function get shotResults() : IShotResultArray
      {
         return _shotResultArray;
      }
      
      private function __E7(param1:Number) : BallLocale
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         while(_loc4_ < _balls.length)
         {
            if(_balls[_loc4_].onTable)
            {
               _loc3_ = findFirstCollisionBall(_balls[_loc4_],param1);
               if(_loc3_ != null)
               {
                  _loc2_ = _loc3_;
                  param1 = _loc2_.time;
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function set paused(param1:Boolean) : void
      {
         __GY = param1;
      }
      
      public function get tableProperties() : __1_
      {
         return __7d;
      }
      
      public function __6m() : void
      {
         _timer.stop();
      }
      
      public function get cueBall() : LogicalBall
      {
         return _balls.length > 0?_balls[0]:null;
      }
      
      public function __Gs(param1:LogicalBall, param2:Point, param3:Boolean = true) : Boolean
      {
         var _loc4_:* = null;
         if(param3 && (param2.x < __FF.left + param1.radius || param2.x > __FF.right - param1.radius || param2.y < __FF.top + param1.radius || param2.y > __FF.bottom - param1.radius))
         {
            return false;
         }
         var _loc5_:* = _balls;
         var _loc8_:int = 0;
         var _loc7_:* = _loc5_;
         for each(_loc4_ in _loc5_)
         {
            if(param1 != _loc4_ && Math.sqrt(__6z(param2.x,param2.y,_loc4_.position.x,_loc4_.position.y)) <= _loc4_.radius + param1.radius)
            {
               return false;
            }
         }
         return true;
      }
      
      private function __2b(param1:Number) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < _balls.length)
         {
            _loc3_ = _balls[_loc4_];
            if(_loc3_.onTable)
            {
               if(_loc3_.spin.x != 0 || _loc3_.spin.y != 0 || _loc3_.spin.z != 0)
               {
                  (_balls[_loc4_] as LogicalBall).__AM(param1);
                  _loc2_ = true;
               }
               __6o.__8d(_balls[_loc4_],param1);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function __H(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc9_:* = null;
         var _loc11_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         _shotResultArray.clear();
         var _loc7_:* = _balls;
         var _loc13_:int = 0;
         var _loc12_:* = _loc7_;
         for each(_loc9_ in _loc7_)
         {
            _loc9_.movable = false;
         }
         _loc11_ = Math.cos(param2);
         _loc10_ = Math.sin(param2);
         _loc6_ = param1 / 685;
         _loc5_ = (1 - Math.sqrt(1 - _loc6_)) * 685;
         cueBall.velocity.x = _loc11_ * _loc5_;
         cueBall.velocity.y = _loc10_ * _loc5_;
         cueBall.spin.x = -_loc10_ * param4 * _loc5_ / cueBall.radius;
         cueBall.spin.y = _loc11_ * param4 * _loc5_ / cueBall.radius;
         cueBall.spin.z = param3 * _loc5_ / cueBall.radius;
         __Ft();
         dispatchEvent(new Event("shotFin"));
      }
      
      public function get __AL() : Array
      {
         return __DJ;
      }
   }
}
