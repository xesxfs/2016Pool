package fls
{
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   
   public class SoundEffect
   {
      
      private static const __GT:Number = 0.7;
      
      private static var __5Q:Class;
      
      private static var __9l:Sound;
      
      private static var __5P:SoundTransform;
      
      private static var __AI:Class;
      
      private static var __Er:Sound;
      
      private static var __EV:Boolean = true;
      
      private static var __FV:Sound;
      
      private static var __3i:Class;
      
      private static var __9D:Class;
      
      private static var __5t:Class;
      
      private static var __2F:Sound;
      
      private static var __0c:Sound;
      
      private static var __Gz:Sound;
      
      private static var __Hi:Class;
      
      private static var __Ea:Sound;
      
      private static var __2h:Class;
       
      
      public function SoundEffect()
      {
         super();
      }
      
      public static function init() : void
      {
         __5Q = SoundBallCollision;
         __Er = new __5Q() as Sound;
         __AI = SoundCueCollision;
         __FV = new __AI() as Sound;
         __Hi = SoundCueWeakCollision;
         __9l = new __Hi() as Sound;
         __3i = SoundCushionCollision;
         __2F = new __3i() as Sound;
         __9D = SoundPocket;
         __Ea = new __9D() as Sound;
         __2h = SoundRunner;
         __0c = new __2h() as Sound;
         __5P = new SoundTransform();
         __EV = true;
      }
      
      public static function get enabled() : Boolean
      {
         return __EV;
      }
      
      public static function set enabled(param1:Boolean) : void
      {
         __EV = param1;
         if(!__EV)
         {
            SoundMixer.stopAll();
         }
      }
      
      public static function playBallCushionCollision(param1:Number) : void
      {
         if(__EV)
         {
            __5P.volume = param1 / 685;
            __2F.play(0,0,__5P);
         }
      }
      
      public static function playCueCollision(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(__EV)
         {
            _loc2_ = param1 / 685;
            __5P.volume = _loc2_;
            if(_loc2_ > 0.7)
            {
               __FV.play(0,0,__5P);
            }
            else
            {
               __9l.play(0,0,__5P);
            }
         }
      }
      
      public static function playBallBallCollision(param1:Number) : void
      {
         if(__EV)
         {
            __5P.volume = param1 / 685;
            __Er.play(0,0,__5P);
         }
      }
      
      public static function playRack() : void
      {
         if(!__EV)
         {
         }
      }
      
      public static function playPocket() : void
      {
         if(__EV)
         {
            __Ea.play();
         }
      }
      
      public static function playRunner() : SoundChannel
      {
         if(__EV)
         {
            return __0c.play();
         }
         return null;
      }
   }
}
