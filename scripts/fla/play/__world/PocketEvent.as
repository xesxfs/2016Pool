package fla.play.__world
{
   import fla.play.__ball.LogicalBall;
   import flash.events.Event;
   
   public class PocketEvent extends Event
   {
      
      public static const POT:String = "ballEnteredPocket";
       
      
      public var ball:LogicalBall;
      
      public function PocketEvent(param1:String, param2:LogicalBall)
      {
         super(param1);
         this.ball = param2;
      }
   }
}
