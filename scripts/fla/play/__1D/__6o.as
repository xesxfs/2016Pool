package fla.play.__1D
{
   import fla.play.__ball.LogicalBall;
   import flash.geom.Point;
   
   public class __6o
   {
      
      public static const __0S:Number = 1.5707963267948966;
      
      public static const __P:Number = 4.71238898038469;
      
      private static const __Cj:Number = 0.2;
      
      public static const __4S:Number = 0.2857142857142857;
      
      public static const __6E:Number = 2.5;
      
      private static const __4O:Number = 0.0111;
      
      private static const __De:Number = 0.54;
      
      private static const __1f:Number = 0.804;
      
      public static const __DU:Number = 35;
      
      private static const __9T:Number = 980.0000000000001;
      
      public static const __72:Number = Math.sqrt(3);
      
      public static const __78:Number = 1.0E-11;
      
      public static const MAX_CUE_LEN:Number = 685;
       
      
      public function __6o()
      {
         super();
      }
      
      public static function __8d(param1:LogicalBall, param2:Number) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         if(!param1.isMovingOrSpinning())
         {
            return;
         }
         var _loc8_:* = -param1.velocity.x - param1.spin.y * param1.radius;
         var _loc10_:* = -param1.velocity.y + param1.spin.x * param1.radius;
         var _loc9_:* = Math.sqrt(_loc8_ * _loc8_ + _loc10_ * _loc10_);
         _loc4_ = __4S * _loc9_ / (0.2 * __9T);
         if(_loc4_ > 1.0e-11)
         {
            _loc6_ = Math.min(_loc4_,param2);
            _loc5_ = 0.2 * __9T * _loc6_;
            _loc8_ = _loc8_ * _loc5_ / _loc9_;
            _loc10_ = _loc10_ * _loc5_ / _loc9_;
            param1.velocity.x = param1.velocity.x + _loc8_;
            param1.velocity.y = param1.velocity.y + _loc10_;
            param1.spin.x = param1.spin.x - __6E * _loc10_ / param1.radius;
            param1.spin.y = param1.spin.y + __6E * _loc8_ / param1.radius;
         }
         if(_loc4_ < param2)
         {
            _loc3_ = param2 - _loc4_;
            _loc5_ = 0.0111 * __9T * _loc3_;
            param1.velocity.scale(Math.max(0,1 - _loc5_ / param1.velocity.length));
            param1.spin.x = param1.velocity.y / param1.radius;
            param1.spin.y = -param1.velocity.x / param1.radius;
         }
         var _loc7_:* = 0.2 / __6E * __9T * param2;
         if(param1.spin.z > 0)
         {
            param1.spin.z = Math.max(0,param1.spin.z - _loc7_);
         }
         else
         {
            param1.spin.z = Math.min(0,param1.spin.z + _loc7_);
         }
      }
      
      public static function ballPointCollisionTime(param1:LogicalBall, param2:Point, param3:Number) : Number
      {
         var _loc4_:* = undefined;
         var _loc9_:* = param1.velocity.x * param1.velocity.x + param1.velocity.y * param1.velocity.y;
         var _loc11_:* = -param1.velocity.x * 2 * (param2.x - param1.position.x) - param1.velocity.y * 2 * (param2.y - param1.position.y);
         var _loc10_:* = (param2.x - param1.position.x) * (param2.x - param1.position.x) + (param2.y - param1.position.y) * (param2.y - param1.position.y);
         var _loc6_:* = 2 * _loc9_;
         var _loc5_:* = 4 * _loc9_;
         var _loc8_:* = _loc11_ * _loc11_;
         var _loc7_:* = param1.radius * param1.radius;
         if(-_loc8_ / _loc5_ + _loc10_ >= _loc7_)
         {
            return Infinity;
         }
         _loc4_ = (-_loc11_ - Math.sqrt(_loc8_ - _loc5_ * (_loc10_ - _loc7_))) / _loc6_;
         if(_loc4_ < 0 || _loc4_ - 1.0e-11 > param3 || _loc11_ > 0)
         {
            return Infinity;
         }
         return _loc4_;
      }
      
      public static function ballLineCollision(param1:LogicalBall, param2:Number) : void
      {
         var _loc10_:* = Math.cos(param2);
         var _loc12_:* = Math.sin(param2);
         var _loc11_:* = _loc10_ * param1.velocity.x - _loc12_ * param1.velocity.y;
         var _loc7_:* = _loc12_ * param1.velocity.x + _loc10_ * param1.velocity.y;
         var _loc6_:* = _loc10_ * param1.spin.x - _loc12_ * param1.spin.y;
         var _loc9_:* = _loc12_ * param1.spin.x + _loc10_ * param1.spin.y;
         _loc6_ = _loc6_ - _loc7_ * 0.54 / param1.radius;
         var _loc8_:* = _loc11_ - param1.spin.z * param1.radius;
         var _loc5_:* = Math.abs(_loc8_);
         var _loc4_:* = Math.min(_loc5_ / __6E,2 * 0.2 * Math.abs(_loc7_));
         var _loc3_:* = -_loc8_ * _loc4_ / _loc5_;
         _loc11_ = _loc11_ + _loc3_;
         param1.spin.z = param1.spin.z - __6E * _loc3_ / param1.radius;
         _loc7_ = -_loc7_ * 0.804;
         param1.velocity.x = _loc10_ * _loc11_ + _loc12_ * _loc7_;
         param1.velocity.y = -_loc12_ * _loc11_ + _loc10_ * _loc7_;
         param1.spin.x = _loc10_ * _loc6_ + _loc12_ * _loc9_;
         param1.spin.y = -_loc12_ * _loc6_ + _loc10_ * _loc9_;
      }
      
      public static function __Cn(param1:Number, param2:Number) : Number
      {
         if(param1 == 0)
         {
            return param2 >= 0?__0S:Number(__P);
         }
         var _loc3_:* = Math.atan(param2 / param1);
         return param1 < 0?_loc3_ + 3.14159265358979:_loc3_;
      }
      
      public static function ballLineCollisionTime(param1:LogicalBall, param2:Point, param3:Point, param4:Number) : Number
      {
         var _loc7_:* = undefined;
         var _loc6_:* = undefined;
         var _loc5_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         if(!param1.__Du())
         {
            return Infinity;
         }
         var _loc12_:* = param3.x - param2.x;
         var _loc14_:* = param3.y - param2.y;
         var _loc13_:* = Math.sqrt(_loc12_ * _loc12_ + _loc14_ * _loc14_);
         var _loc9_:* = -_loc14_ / _loc13_;
         var _loc8_:* = _loc12_ / _loc13_;
         var _loc11_:* = param1.position.x - param2.x - _loc9_ * param1.radius;
         var _loc10_:* = param1.position.y - param2.y - _loc8_ * param1.radius;
         _loc7_ = _loc12_ * -param1.velocity.y - _loc14_ * -param1.velocity.x;
         if(_loc7_ == 0)
         {
            return Infinity;
         }
         _loc6_ = -param1.velocity.y * _loc11_ - -param1.velocity.x * _loc10_;
         _loc5_ = _loc6_ / _loc7_;
         if(_loc5_ <= 0 || _loc5_ >= 1)
         {
            return Infinity;
         }
         _loc15_ = _loc12_ * _loc10_ - _loc14_ * _loc11_;
         _loc16_ = _loc15_ / _loc7_;
         if(_loc16_ <= 0 || _loc16_ - 1.0e-11 > param4)
         {
            return Infinity;
         }
         _loc17_ = _loc9_ * param1.velocity.x + _loc8_ * param1.velocity.y;
         if(_loc17_ > 0)
         {
            return Infinity;
         }
         return _loc16_;
      }
      
      public static function ballBallCollisionTime(param1:LogicalBall, param2:LogicalBall, param3:Number) : Number
      {
         var _loc4_:* = undefined;
         var _loc10_:* = param1.radius + param2.radius;
         var _loc12_:* = param2.position.x - param1.position.x;
         var _loc11_:* = param2.position.y - param1.position.y;
         var _loc7_:* = param2.velocity.x - param1.velocity.x;
         var _loc6_:* = param2.velocity.y - param1.velocity.y;
         var _loc9_:* = _loc7_ * _loc7_ + _loc6_ * _loc6_;
         var _loc8_:* = 2 * (_loc12_ * _loc7_ + _loc11_ * _loc6_);
         var _loc5_:* = _loc12_ * _loc12_ + _loc11_ * _loc11_ - _loc10_ * _loc10_;
         _loc4_ = (-_loc8_ - Math.sqrt(_loc8_ * _loc8_ - _loc9_ * 4 * _loc5_)) / (_loc9_ * 2);
         if(_loc4_ < 0 || _loc4_ - 1.0e-11 > param3 || _loc8_ >= 0)
         {
            return Infinity;
         }
         return _loc4_;
      }
      
      public static function __4z(param1:Number, param2:Number, param3:Number, param4:Number, param5:Array) : void
      {
         var _loc8_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc6_:Number = NaN;
         param2 = param2 - param1;
         if(Math.abs(param2) < param4)
         {
            _loc8_ = param3 * param3;
            _loc10_ = Math.abs(param2 * param2 + _loc8_);
            _loc9_ = Math.sqrt(_loc8_ - _loc10_ + param4 * param4);
            _loc7_ = param3 + _loc9_;
            _loc6_ = param3 - _loc9_;
            param5.push(new Point(param1,_loc7_));
            param5.push(new Point(param1,_loc6_));
         }
      }
      
      public static function __8H(param1:Number, param2:Number, param3:Number, param4:Number, param5:Array) : void
      {
         var _loc8_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc6_:Number = NaN;
         param3 = param3 - param1;
         if(Math.abs(param3) < param4)
         {
            _loc8_ = param2 * param2;
            _loc10_ = Math.abs(param3 * param3 + _loc8_);
            _loc9_ = Math.sqrt(_loc8_ - _loc10_ + param4 * param4);
            _loc7_ = param2 + _loc9_;
            _loc6_ = param2 - _loc9_;
            param5.push(new Point(_loc7_,param1));
            param5.push(new Point(_loc6_,param1));
         }
      }
      
      public static function ballBallCollision(param1:LogicalBall, param2:LogicalBall) : void
      {
         var _loc8_:* = undefined;
         var _loc16_:* = undefined;
         var _loc10_:* = param1.velocity.length + param2.velocity.length;
         var _loc12_:* = param1.position.x - param2.position.x;
         var _loc11_:* = param1.position.y - param2.position.y;
         var _loc7_:* = Math.sqrt(_loc12_ * _loc12_ + _loc11_ * _loc11_);
         var _loc6_:* = _loc12_ / _loc7_;
         var _loc9_:* = _loc11_ / _loc7_;
         _loc8_ = param1.velocity.x * -_loc6_ + param1.velocity.y * -_loc9_;
         var _loc5_:* = _loc8_ * -_loc6_;
         var _loc4_:* = _loc8_ * -_loc9_;
         var _loc3_:* = _loc5_ - param1.velocity.x;
         var _loc15_:* = _loc4_ - param1.velocity.y;
         _loc16_ = param2.velocity.x * _loc6_ + param2.velocity.y * _loc9_;
         var _loc17_:* = _loc16_ * _loc6_;
         var _loc18_:* = _loc16_ * _loc9_;
         var _loc13_:* = _loc17_ - param2.velocity.x;
         var _loc14_:* = _loc18_ - param2.velocity.y;
         param1.velocity.x = -_loc3_ + _loc17_;
         param1.velocity.y = -_loc15_ + _loc18_;
         param2.velocity.x = -_loc13_ + _loc5_;
         param2.velocity.y = -_loc14_ + _loc4_;
      }
   }
}
