package fla.play.__locale
{
   import fla.play.__ball.LogicalBall;
   
   public class BallLocale2 extends BallLocale
   {
       
      
      private var m_cBall:LogicalBall;
      
      public function BallLocale2(param1:LogicalBall, param2:Number, param3:Number)
      {
         super(param2,param3);
         m_cBall = param1;
      }
      
      public function get ball() : LogicalBall
      {
         return m_cBall;
      }
   }
}
