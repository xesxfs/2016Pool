package fla.play.__locale
{
   import fla.play.__ball.LogicalBall;
   
   public class BallLocale3 extends BallLocale2
   {
       
      
      private var __0m:Number;
      
      public function BallLocale3(param1:LogicalBall, param2:Number, param3:Number, param4:Number)
      {
         super(param1,param3,param4);
         __0m = param2;
      }
      
      public function get __96() : Number
      {
         return __0m;
      }
   }
}
