package fla.play.__world
{
   import flash.events.Event;
   
   public class CollisionEvent extends Event
   {
      
      public static const BBC:String = "tableBallBallCollision";
      
      public static const BCC:String = "tableBallCushionCollision";
       
      
      private var _array:Array;
      
      public function CollisionEvent(param1:String)
      {
         _array = [];
         super(param1);
      }
      
      public function get array() : Array
      {
         return _array;
      }
   }
}
