package fla.play.__world
{
   import fla.play.__ball.LogicalBall;
   import fla.play.__locale.BallLocale2;
   import fla.play.__locale.__Fn;
   
   public class ShotResultArray implements IShotResultArray
   {
       
      
      private var _balls:Array;
      
      private var __Dw:Array;
      
      private var __7S:Array;
      
      public function ShotResultArray()
      {
         _balls = [];
         __7S = [];
         __Dw = [];
         super();
      }
      
      public function get ballCollisions() : Array
      {
         return __Dw;
      }
      
      public function get numBalls() : Number
      {
         return _balls.length;
      }
      
      public function clear() : void
      {
         _balls.length = 0;
         __7S.length = 0;
         __Dw.length = 0;
      }
      
      public function get __6a() : LogicalBall
      {
         if(__Dw.length == 0)
         {
            return null;
         }
         return (__Dw[0] as __Fn).ballA.classification != 0?(__Dw[0] as __Fn).ballA:(__Dw[0] as __Fn).ballB;
      }
      
      public function ballCushionCollision(param1:BallLocale2) : void
      {
         __7S.push(param1);
      }
      
      public function ballPocketed(param1:LogicalBall) : void
      {
         _balls.push(param1);
      }
      
      public function get cushionCollisions() : Array
      {
         return __7S;
      }
      
      public function ballBallCollision(param1:__Fn) : void
      {
         __Dw.push(param1);
      }
      
      public function indexOf(param1:LogicalBall) : Boolean
      {
         return _balls.lastIndexOf(param1) > -1;
      }
      
      public function get __Gg() : Array
      {
         return _balls;
      }
   }
}
