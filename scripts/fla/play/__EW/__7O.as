package fla.play.__EW
{
   public class __7O
   {
       
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var z:Number = 0;
      
      public function __7O(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         x = param1;
         y = param2;
         z = param3;
      }
      
      public function __5K(param1:Number) : void
      {
         var _loc3_:Number = Math.sin(param1);
         var _loc4_:Number = Math.cos(param1);
         var _loc2_:Number = _loc4_ * x - _loc3_ * y;
         y = _loc3_ * x + _loc4_ * y;
         x = _loc2_;
      }
      
      public function __Dz() : void
      {
         scale(1 / length);
      }
      
      public function get length() : Number
      {
         return Math.sqrt(x * x + y * y + z * z);
      }
      
      public function dot(param1:__7O) : Number
      {
         return x * param1.x + y * param1.y + z * param1.z;
      }
      
      public function scale(param1:Number) : void
      {
         x = x * param1;
         y = y * param1;
         z = z * param1;
      }
      
      public function __BA(param1:__7O) : void
      {
         var _loc12_:Number = param1.length;
         if(_loc12_ == 0)
         {
            return;
         }
         var _loc14_:Number = param1.x / _loc12_;
         var _loc2_:Number = param1.y / _loc12_;
         var _loc3_:Number = param1.z / _loc12_;
         var _loc4_:Number = _loc14_ * x;
         var _loc5_:Number = _loc14_ * y;
         var _loc6_:Number = _loc14_ * z;
         var _loc7_:Number = _loc2_ * x;
         var _loc13_:Number = _loc2_ * y;
         var _loc9_:Number = _loc2_ * z;
         var _loc8_:Number = _loc3_ * x;
         var _loc11_:Number = _loc3_ * y;
         var _loc10_:Number = _loc3_ * z;
         var _loc15_:Number = Math.sin(_loc12_);
         var _loc16_:Number = Math.cos(_loc12_);
         x = _loc14_ * (_loc4_ + _loc13_ + _loc10_) + (x * (_loc2_ * _loc2_ + _loc3_ * _loc3_) - _loc14_ * (_loc13_ + _loc10_)) * _loc16_ + (-_loc11_ + _loc9_) * _loc15_;
         y = _loc2_ * (_loc4_ + _loc13_ + _loc10_) + (y * (_loc14_ * _loc14_ + _loc3_ * _loc3_) - _loc2_ * (_loc4_ + _loc10_)) * _loc16_ + (_loc8_ - _loc6_) * _loc15_;
         z = _loc3_ * (_loc4_ + _loc13_ + _loc10_) + (z * (_loc14_ * _loc14_ + _loc2_ * _loc2_) - _loc3_ * (_loc4_ + _loc13_)) * _loc16_ + (-_loc7_ + _loc5_) * _loc15_;
      }
      
      public function set length(param1:Number) : void
      {
         scale(param1 / length);
      }
      
      public function __66(param1:Number) : void
      {
         var _loc3_:Number = Math.sin(param1);
         var _loc4_:Number = Math.cos(param1);
         var _loc2_:Number = _loc4_ * x + _loc3_ * z;
         z = -_loc3_ * x + _loc4_ * z;
         x = _loc2_;
      }
      
      public function __Fl(param1:__7O) : void
      {
         x = param1.x;
         y = param1.y;
         z = param1.z;
      }
      
      public function init(param1:Number = 0, param2:Number = 0, param3:Number = 0) : void
      {
         x = param1;
         y = param2;
         z = param3;
      }
      
      public function __Da(param1:Number) : void
      {
         var _loc3_:Number = Math.sin(param1);
         var _loc4_:Number = Math.cos(param1);
         var _loc2_:Number = _loc4_ * y - _loc3_ * z;
         z = _loc3_ * y + _loc4_ * z;
         y = _loc2_;
      }
   }
}
