package fla.play.__locale
{
   import fla.play.__ball.LogicalBall;
   
   public class __Fn extends BallLocale
   {
       
      
      private var __4T:LogicalBall;
      
      private var __3s:LogicalBall;
      
      public function __Fn(param1:LogicalBall, param2:LogicalBall, param3:Number, param4:Number)
      {
         super(param3,param4);
         __4T = param1;
         __3s = param2;
      }
      
      public function ballCollided(param1:LogicalBall) : Boolean
      {
         return param1 == __4T || param1 == __3s;
      }
      
      public function get ballA() : LogicalBall
      {
         return __4T;
      }
      
      public function get ballB() : LogicalBall
      {
         return __3s;
      }
      
      public function ballClassificationCollided(param1:int) : Boolean
      {
         return __4T.classification == param1 || __3s.classification == param1;
      }
   }
}
