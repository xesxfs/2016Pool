package fla.play.ui
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class CountDownPart extends Sprite
   {
       
      
      public var _text:TextField;
      
      private var _tid:int;
      
      private var _total:int;
      
      private var _seconds:int;
      
      private var _end:Function;
      
      private var _pause:Boolean;
      
      public function CountDownPart()
      {
         super();
         _text.mouseEnabled = false;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.letterSpacing = 1;
         _text.defaultTextFormat = _loc1_;
         this.addEventListener("addedToStage",onAddedToStage);
      }
      
      public static function getFormatTime(param1:int) : String
      {
         var _loc3_:int = param1 / 60;
         var _loc4_:int = param1 % 60;
         var _loc5_:String = _loc3_.toString();
         var _loc2_:String = _loc4_.toString();
         if(_loc3_ < 10)
         {
            _loc5_ = "0" + _loc3_;
         }
         if(_loc4_ < 10)
         {
            _loc2_ = "0" + _loc4_;
         }
         return _loc5_ + ":" + _loc2_;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.removeEventListener("addedToStage",onAddedToStage);
         this.addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         stop();
      }
      
      public function start(param1:int, param2:Function) : void
      {
         _end = param2;
         _total = param1;
         _seconds = param1;
         _tid = setInterval(onTimer,1000);
         onUpdate();
      }
      
      public function stop() : void
      {
      }
      
      public function pause(param1:Boolean) : void
      {
         _pause = param1;
      }
      
      private function onTimer() : void
      {
         if(_pause == true)
         {
            return;
         }
         _seconds = Number(_seconds) - 1;
         onUpdate();
         if(_seconds == 0)
         {
            stop();
            if(_end != null)
            {
               _end();
               _end = null;
            }
         }
      }
      
      private function onUpdate() : void
      {
         _text.text = getFormatTime(_seconds);
      }
      
      public function getSeconds() : int
      {
         return _total - _seconds;
      }
   }
}
