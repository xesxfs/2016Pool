package fla.play.__EW
{
   public class Coord
   {
       
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public function Coord()
      {
         super();
      }
      
      public function add(param1:Number, param2:Number) : void
      {
         x = x + param1;
         y = y + param2;
      }
      
      public function __Dz() : void
      {
         scale(1 / length);
      }
      
      public function get length() : Number
      {
         return Math.sqrt(x * x + y * y);
      }
      
      public function scale(param1:Number) : void
      {
         x = x * param1;
         y = y * param1;
      }
      
      public function set length(param1:Number) : void
      {
         if(x != 0 || y != 0)
         {
            scale(param1 / length);
         }
      }
      
      public function init(param1:Number = 0, param2:Number = 0) : void
      {
         x = param1;
         y = param2;
      }
      
      public function setByCoord(param1:Coord) : void
      {
         x = param1.x;
         y = param1.y;
      }
      
      public function setByAngle(param1:Number) : void
      {
         var _loc3_:Number = Math.sin(param1);
         var _loc4_:Number = Math.cos(param1);
         var _loc2_:Number = _loc4_ * x - _loc3_ * y;
         y = _loc3_ * x + _loc4_ * y;
         x = _loc2_;
      }
   }
}
