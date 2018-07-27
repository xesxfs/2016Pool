package fla.play.__layout
{
   import fla.play.__ball.LogicalBall;
   
   public class BallLayout implements IBallLayout
   {
      
      public static const __97:int = 0;
      
      protected static const __2D:Number = 2.8575;
      
      protected static const __Ge:Number = __Aa / 2;
      
      protected static const __5Z:Number = 0.02;
      
      protected static const __7B:Number = 0.05;
      
      protected static const __CQ:Number = 0.02;
      
      protected static const __6n:Number = 1.33;
      
      protected static const __Aa:Number = 0.04;
       
      
      private var __j:Vector.<LogicalBall>;
      
      public function BallLayout()
      {
         __j = new Vector.<LogicalBall>();
         super();
         __j.push(new LogicalBall(0,ballRadius,0));
      }
      
      public function get ballRadius() : Number
      {
         return 2.8575 * 1.33;
      }
      
      public function rackUp() : void
      {
         (__j[0] as LogicalBall).setPosition(0,0);
      }
      
      public function get balls() : Vector.<LogicalBall>
      {
         return __j;
      }
      
      protected function get __6d() : Number
      {
         return (Math.random() - 0.5) * 0.02;
      }
   }
}
