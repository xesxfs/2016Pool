package fla.play.__tween
{
   import fla.play.PlayMain;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   
   public class __Timer
   {
      
      public static var center:EventDispatcher = new EventDispatcher();
      
      private static const TIME_SCALE:Number = 1;
       
      
      private var _sprite:Sprite;
      
      private var onMoving:Function;
      
      private var __8U:Number;
      
      public var running:Boolean;
      
      private var _sumTime:Number;
      
      private var _startTime:Number;
      
      private var onRender:Function;
      
      private var _frameTime:Number;
      
      public function __Timer(param1:Function, param2:Function, param3:Number = 1)
      {
         super();
         running = false;
         __8U = 1;
         onMoving = param1;
         onRender = param2;
         _sprite = new Sprite();
         center.addEventListener("KILL_ALL",onKillAll,false,0,true);
      }
      
      public static function killAll() : void
      {
         center.dispatchEvent(new Event("KILL_ALL"));
      }
      
      public function onKillAll(param1:Event) : void
      {
         center.removeEventListener("KILL_ALL",onKillAll);
         stop();
      }
      
      public function start() : void
      {
         if(running)
         {
            return;
         }
         _frameTime = getFrameTime();
         _startTime = getTimer();
         _sumTime = 0;
         running = true;
         _sprite.addEventListener("enterFrame",onEnterFrame,false,0,true);
      }
      
      public function stop() : void
      {
         if(!running)
         {
            return;
         }
         running = false;
         _frameTime = 0;
         _sprite.removeEventListener("enterFrame",onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         onMoving(_frameTime);
         _sumTime = _sumTime + _frameTime;
      }
      
      public function getFrameTime() : Number
      {
         return 1 / (PlayMain.self.stage.frameRate * __8U);
      }
   }
}
