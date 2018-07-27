package fla.play.__world
{
   import fla.play.__ball.LogicalBall;
   
   public interface IShotResultArray
   {
       
      
      function get ballCollisions() : Array;
      
      function get cushionCollisions() : Array;
      
      function get numBalls() : Number;
      
      function get __6a() : LogicalBall;
      
      function indexOf(param1:LogicalBall) : Boolean;
      
      function get __Gg() : Array;
   }
}
