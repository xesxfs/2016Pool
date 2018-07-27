package fla.play.__cue
{
   import flash.events.Event;
   
   public class CueEvent extends Event
   {
      
      public static const SHOOT:String = "shoot";
      
      public static const SHOT_FIN:String = "shotFin";
      
      public static const SHOT_MISS:String = "shotMiss";
      
      public static const SHOT_NOT_POT:String = "shotNotPot";
       
      
      public function CueEvent(param1:String)
      {
         super(param1);
      }
   }
}
