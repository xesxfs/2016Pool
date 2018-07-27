package fla.play.ui
{
   import fla.play.PlayMain;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class PowerPart extends Sprite
   {
       
      
      public var _cue:MovieClip;
      
      public var _bg:MovieClip;
      
      private var _maxX:int;
      
      private var _maxW:int;
      
      private var _powerStartX:int;
      
      private var _powerCrood:Point;
      
      public function PowerPart()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         _maxX = _cue.x;
         _maxW = _cue.width;
         _cue.stop();
      }
      
      public function update(param1:Number) : void
      {
         _cue.x = int(_maxX - param1);
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this.mouseEnabled = param1;
         this.removeEventListener("mouseDown",onMouseDown);
         if(param1)
         {
            this.addEventListener("mouseDown",onMouseDown);
         }
      }
      
      public function onMouseDown(param1:Event) : void
      {
         if(PlayMain.self.body._cue.visible == false)
         {
            return;
         }
         stage.addEventListener("mouseMove",onMouseMove,false,1,true);
         stage.addEventListener("mouseUp",onMouseUp,false,1,true);
         stage.addEventListener("releaseOutside",onMouseUp,false,1,true);
         PlayMain.self.body._cue.enabled = false;
         _powerStartX = PlayMain.self.mouseX;
         _powerCrood = PlayMain.self.body._cue.getPointBy(0);
         PlayMain.self.body._cue.setPowerPointA(_powerCrood.x,_powerCrood.y);
      }
      
      public function onMouseUp(param1:Event) : void
      {
         stage.removeEventListener("mouseMove",onMouseMove);
         stage.removeEventListener("mouseUp",onMouseUp);
         stage.removeEventListener("releaseOutside",onMouseUp);
         if(param1 == null)
         {
            return;
         }
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         PlayMain.self.body._cue.releasePowerPoint();
         _powerCrood = null;
         _powerStartX = 0;
      }
      
      public function onMouseMove(param1:Event) : void
      {
         var _loc4_:int = PlayMain.self.mouseX;
         var _loc3_:int = _powerStartX - _loc4_;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         var _loc2_:Number = _loc3_ / _maxX;
         if(_loc2_ > 0.5)
         {
            return;
         }
         if(PlayMain.self.body._cue.visible == false)
         {
            return;
         }
         _powerCrood = PlayMain.self.body._cue.getPointBy(_loc2_);
         PlayMain.self.body._cue.setPowerPointB(_powerCrood.x,_powerCrood.y);
      }
   }
}
