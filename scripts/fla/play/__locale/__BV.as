package fla.play.__locale
{
   import fla.play.__ball.LogicalBall;
   import flash.geom.Point;
   
   public class __BV extends BallLocale2
   {
       
      
      private var m_cPoint:Point;
      
      public function __BV(param1:LogicalBall, param2:Point, param3:Number, param4:Number)
      {
         super(param1,param3,param4);
         m_cPoint = param2;
      }
      
      public function get point() : Point
      {
         return m_cPoint;
      }
   }
}
