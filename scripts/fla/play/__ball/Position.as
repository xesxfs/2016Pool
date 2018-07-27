package fla.play.__ball
{
   import flash.geom.Point;
   
   public class Position
   {
       
      
      public var _point:Point;
      
      public var _angle:Number;
      
      public function Position(param1:Point, param2:Number)
      {
         super();
         _point = param1;
         _angle = param2;
      }
      
      public function __Bt(param1:Number) : Number
      {
         return param1 / _angle;
      }
      
      public function __A2(param1:Number) : Number
      {
         return param1 * _angle;
      }
      
      public function getVisualXPosition(param1:Number) : Number
      {
         return _point.x + param1 * _angle;
      }
      
      public function getVisualYPosition(param1:Number) : Number
      {
         return _point.y + param1 * _angle;
      }
      
      public function getVisualPoint(param1:Point) : Point
      {
         return new Point(getVisualXPosition(param1.x),getVisualYPosition(param1.y));
      }
      
      public function getLogicalX(param1:Number) : Number
      {
         return (param1 - _point.x) / _angle;
      }
      
      public function getLogicalY(param1:Number) : Number
      {
         return (param1 - _point.y) / _angle;
      }
      
      public function getLogicalPoint(param1:Point) : Point
      {
         return new Point(getLogicalX(param1.x),getLogicalY(param1.y));
      }
   }
}
