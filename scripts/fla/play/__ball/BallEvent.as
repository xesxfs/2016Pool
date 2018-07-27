package fla.play.__ball
{
   import flash.events.Event;
   
   public class BallEvent extends Event
   {
      
      public static const STATE:String = "ballChangedState";
       
      
      private var __1U:uint;
      
      private var __C3:uint;
      
      public function BallEvent(param1:String, param2:uint, param3:uint)
      {
         super(param1);
         __C3 = param2;
         __1U = param3;
      }
      
      public function get fromState() : uint
      {
         return __C3;
      }
      
      public function get toState() : uint
      {
         return __1U;
      }
   }
}
