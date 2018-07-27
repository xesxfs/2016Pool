package fla.play.__layout
{
   import fla.play.PlayBody;
   import fla.play.PlayMain;
   import fla.play.__1D.__6o;
   import fla.play.__ball.LogicalBall;
   import fla.play.__world.World;
   import flash.geom.Point;
   
   public class BallLayout9 extends BallLayout
   {
      
      public static const __7Q:int = 1;
      
      public static const __G4:int = 2;
       
      
      public function BallLayout9()
      {
         super();
         var _loc1_:int = 1;
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            balls.push(new LogicalBall(_loc1_++,ballRadius,1));
            _loc2_++;
         }
         balls.push(new LogicalBall(_loc1_++,ballRadius,2));
      }
      
      public function __4i(param1:World) : void
      {
         var _loc8_:* = null;
         var _loc4_:* = 0;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = __4Q;
         var _loc9_:* = [];
         var _loc2_:* = balls;
         var _loc11_:int = 0;
         var _loc10_:* = _loc2_;
         for each(_loc8_ in _loc2_)
         {
            if(_loc8_.state != 1)
            {
               _loc9_.push(_loc8_);
            }
         }
         _loc4_ = _loc7_.length - 1;
         while(_loc9_.length > 0)
         {
            _loc3_ = _loc9_.splice(Math.random() * _loc9_.length,1)[0];
            _loc6_ = _loc7_[_loc4_--];
            param1.respotBall(_loc3_,_loc6_.x,_loc6_.y,0);
         }
      }
      
      override public function rackUp() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc7_:Vector.<LogicalBall> = balls.concat();
         var _loc1_:int = PlayMain.self.getGameMode();
         if(_loc1_ == 0)
         {
            _loc4_ = defaultLayout;
            (_loc7_.splice(0,1)[0] as LogicalBall).setPosition(-63.5,0);
            _loc2_ = _loc4_.splice(0,1)[0] as Point;
            (_loc7_.splice(0,1)[0] as LogicalBall).setPosition(_loc2_.x,_loc2_.y);
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               _loc3_ = _loc7_[_loc8_];
               if(_loc3_.classification == 2)
               {
                  _loc2_ = _loc4_.splice(3,1)[0];
                  _loc3_.setPosition(_loc2_.x,_loc2_.y);
                  _loc7_.splice(_loc8_,1);
                  break;
               }
               _loc8_++;
            }
            while(_loc7_.length > 0 && _loc4_.length > 0)
            {
               _loc2_ = _loc4_.splice(Math.random() * _loc4_.length,1)[0];
               (_loc7_.pop() as LogicalBall).setPosition(_loc2_.x,_loc2_.y);
            }
         }
         else
         {
            _loc5_ = [];
            _loc4_ = PlayMain.self.getLayout();
            _loc8_ = 0;
            _loc6_ = _loc7_.length;
            _loc7_.length;
            while(_loc8_ < _loc6_)
            {
               _loc2_ = new Point(_loc4_[_loc8_ * 2 + 0],_loc4_[_loc8_ * 2 + 1]);
               _loc2_ = PlayBody.centerPos.getLogicalPoint(_loc2_);
               (_loc7_[_loc8_] as LogicalBall).setPosition(_loc2_.x,_loc2_.y);
               _loc8_++;
            }
         }
      }
      
      private function get defaultLayout() : Array
      {
         var _loc6_:* = 0;
         var _loc5_:* = NaN;
         var _loc2_:* = NaN;
         var _loc1_:* = null;
         var _loc7_:* = [];
         var _loc9_:* = new Point(63.5 + (Math.random() - 0.5) * 0.05,(Math.random() - 0.5) * 0.05);
         var _loc8_:* = balls[0].radius;
         var _loc4_:* = _loc9_.x;
         var _loc3_:int = 1;
         while(_loc3_ < 6)
         {
            _loc6_ = Math.min(_loc3_,6 - _loc3_);
            _loc5_ = _loc9_.y - (_loc6_ - 1) * (_loc8_ + 0.04);
            _loc2_ = 0;
            while(_loc2_ < _loc6_)
            {
               _loc1_ = new Point(_loc4_ + __6d,_loc5_ + __6d);
               if(_loc2_ < _loc3_ / 2)
               {
                  _loc1_.y = _loc1_.y + __Ge / 2;
               }
               else if(_loc2_ > _loc3_ / 2)
               {
                  _loc1_.y = _loc1_.y - __Ge / 2;
               }
               _loc1_.x = _loc1_.x + Math.abs(_loc2_ - _loc3_ / 2) * 0.04;
               _loc7_.push(_loc1_);
               _loc5_ = _loc5_ + (_loc8_ + 0.04) * 2;
               _loc2_++;
            }
            _loc4_ = _loc4_ + (__6o.__72 * _loc8_ + 0.04);
            _loc3_++;
         }
         return _loc7_;
      }
      
      private function get __4Q() : Array
      {
         var _loc5_:* = NaN;
         var _loc4_:* = NaN;
         var _loc1_:* = null;
         var _loc6_:* = [];
         var _loc8_:* = new Point(63.5 + (Math.random() - 0.5) * 0.05,(Math.random() - 0.5) * 0.05);
         var _loc7_:* = balls[0].radius;
         var _loc3_:* = _loc8_.x;
         var _loc2_:int = 1;
         while(_loc2_ < 6)
         {
            _loc5_ = _loc8_.y - (_loc2_ - 1) * (_loc7_ + 0.04);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc1_ = new Point(_loc3_ + __6d,_loc5_ + __6d);
               if(_loc4_ < _loc2_ / 2)
               {
                  _loc1_.y = _loc1_.y + __Ge / 2;
               }
               else if(_loc4_ > _loc2_ / 2)
               {
                  _loc1_.y = _loc1_.y - __Ge / 2;
               }
               _loc1_.x = _loc1_.x + Math.abs(_loc4_ - _loc2_ / 2) * 0.04;
               _loc6_.push(_loc1_);
               _loc5_ = _loc5_ + (_loc7_ + 0.04) * 2;
               _loc4_++;
            }
            _loc3_ = _loc3_ + (__6o.__72 * _loc7_ + 0.04);
            _loc2_++;
         }
         return _loc6_;
      }
   }
}
