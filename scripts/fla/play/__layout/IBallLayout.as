package fla.play.__layout
{
   import fla.play.__ball.LogicalBall;
   
   public interface IBallLayout
   {
       
      
      function rackUp() : void;
      
      function get balls() : Vector.<LogicalBall>;
   }
}
