package fla.play.__cue
{
   import com.greensock.TweenMax;
   import fla.play.PlayMain;
   import fla.play.__1D.__6o;
   import fla.play.__ball.Position;
   import fla.play.__world.World;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class Cue extends Sprite
   {
       
      
      private var __6K:World;
      
      private var _power:Number;
      
      private var _bmd:BitmapData;
      
      private var _line:CueLine;
      
      private var _perLen:Number;
      
      private var _powerStart:Point;
      
      private var __77:Number = 100;
      
      private var _frame:Sprite;
      
      private var _enabled:Boolean;
      
      private var __3L:Number;
      
      private var __33:Position;
      
      private var _actived:Boolean;
      
      private var _offset:int;
      
      private var _assit:CueAssit;
      
      public function Cue(param1:BitmapData, param2:World, param3:Position, param4:Sprite)
      {
         super();
         _perLen = __77 / 685;
         _bmd = param1;
         __33 = param3;
         __6K = param2;
         _line = new CueLine(param2,param3);
         _line.mouseEnabled = false;
         _assit = new CueAssit();
         _frame = param4;
         _enabled = false;
         power = 0;
         rotation = 90;
         _actived = false;
         visible = false;
         filters = [new DropShadowFilter(4,90,0,0.5,10,10,1,2)];
         _assit.mouseEnabled = false;
         _assit.alpha = 0;
         _assit.visible = false;
         addChild(_assit);
         this.addEventListener("removedFromStage",onRemovedFromStage);
         this.addEventListener("mouseDown",onMouseDownCue);
         _assit.addEventListener("mouseDown",onClickAssit);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeEventListener("removedFromStage",onRemovedFromStage);
         this.enabled = false;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         .super.visible = param1;
         _line.visible = param1;
         if(param1)
         {
            upate();
         }
         else
         {
            alpha = 0;
            _line.alpha = 0;
         }
      }
      
      public function rotateTo(param1:Number, param2:Number, param3:int = 0) : void
      {
         var _loc4_:Number = 90 + __6o.__Cn(param1 - x,param2 - y) / (3.14159265358979 * 2) * 360;
         _loc4_ = _loc4_ + param3;
         rotation = _loc4_;
      }
      
      private function upate() : void
      {
         if(_actived)
         {
            TweenMax.to(this,0.5,{"alpha":1});
            TweenMax.to(_line,0.5,{"alpha":1});
         }
         else
         {
            TweenMax.to(this,0.5,{"alpha":0.5});
            TweenMax.to(_line,0.5,{"alpha":0.5});
         }
      }
      
      public function moveToCueBall() : void
      {
         move(__33.getVisualXPosition(__6K.cueBall.position.x),__33.getVisualYPosition(__6K.cueBall.position.y));
         _line.__06(logicalRotation);
      }
      
      public function move(param1:int, param2:*) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function get logicalRotation() : Number
      {
         var _loc1_:Number = rotation - 90 < 0?rotation + 360 - 90:Number(rotation - 90);
         return _loc1_ / 360 * 3.14159265358979 * 2;
      }
      
      public function set logicalRotation(param1:Number) : void
      {
         rotation = (param1 + 1.5707963267949) * 360 / (3.14159265358979 * 2);
      }
      
      public function set power(param1:Number) : void
      {
         _power = Math.max(0,Math.min(685,param1));
         _offset = _power * _perLen;
         var _loc2_:Matrix = new Matrix();
         _loc2_.translate(-_bmd.width / 2,_offset + 12);
         graphics.clear();
         graphics.beginBitmapFill(_bmd,_loc2_,true,true);
         graphics.drawRect(-_bmd.width / 2,_offset + 12,_bmd.width,_bmd.height);
      }
      
      public function get power() : Number
      {
         return _power;
      }
      
      private function getPowerByCrood(param1:Number, param2:Number) : Number
      {
         var _loc7_:Number = logicalRotation + 3.14159265358979;
         var _loc3_:Number = param1 - _powerStart.x;
         var _loc4_:Number = param2 - _powerStart.y;
         var _loc5_:Number = _loc3_ * Math.cos(logicalRotation) + _loc4_ * Math.sin(logicalRotation);
         var _loc6_:Number = _loc4_ * Math.cos(logicalRotation) - _loc3_ * Math.sin(logicalRotation);
         return -_loc5_ / _perLen;
      }
      
      public function getPointBy(param1:Number) : Point
      {
         var _loc2_:int = _bmd.height;
         var _loc3_:int = _loc2_ * param1;
         var _loc4_:Point = localToGlobal(new Point(0,_loc3_));
         return _loc4_;
      }
      
      public function get visualGuide() : CueLine
      {
         return _line;
      }
      
      public function shoot() : void
      {
         dispatchEvent(new CueEvent("shoot"));
      }
      
      override public function set rotation(param1:Number) : void
      {
         .super.rotation = param1;
         _line.__06(logicalRotation);
      }
      
      public function set active(param1:Boolean) : void
      {
         if(_frame == null || param1 == _actived)
         {
            return;
         }
         if(param1)
         {
            _frame.addEventListener("mouseDown",onMouseDownFrame);
            PlayMain.self.ui._powerPart.enabled = true;
         }
         else
         {
            _frame.removeEventListener("mouseDown",onMouseDownFrame);
         }
         _actived = param1;
         upate();
      }
      
      public function get active() : Boolean
      {
         return _actived;
      }
      
      private function setAssitAlhpa(param1:Number) : void
      {
         v = param1;
         if(_assit.alpha == v)
         {
            return;
         }
         if(v == 1)
         {
            _assit.visible = true;
         }
         TweenMax.killTweensOf(_assit);
         TweenMax.to(_assit,0.2,{
            "alpha":v,
            "onComplete":function():void
            {
               if(v == 0)
               {
                  _assit.visible = false;
               }
            }
         });
      }
      
      public function onMouseDownFrame(param1:MouseEvent) : void
      {
         stage.addEventListener("mouseMove",onMouseMoveFrame,false,0,true);
         stage.addEventListener("mouseUp",onMouseUpFrame,false,0,true);
         stage.addEventListener("releaseOutside",onMouseUpFrame,false,0,true);
         var _loc2_:Point = new Point(param1.stageX,param1.stageY);
         _loc2_ = root.globalToLocal(_loc2_);
         rotateTo(_loc2_.x,_loc2_.y);
         setAssitAlhpa(0);
      }
      
      public function onMouseMoveFrame(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(visible)
         {
            _loc2_ = new Point(param1.stageX,param1.stageY);
            _loc2_ = root.globalToLocal(_loc2_);
            rotateTo(_loc2_.x,_loc2_.y);
         }
      }
      
      public function onMouseUpFrame(param1:MouseEvent) : void
      {
         stage.removeEventListener("mouseMove",onMouseMoveFrame);
         stage.removeEventListener("mouseUp",onMouseUpFrame);
         stage.removeEventListener("releaseOutside",onMouseUpFrame);
         setAssitAlhpa(1);
      }
      
      public function setPowerPointA(param1:Number, param2:Number) : void
      {
         _powerStart = new Point(param1,param2);
         setAssitAlhpa(0);
      }
      
      public function setPowerPointB(param1:Number, param2:Number) : void
      {
         power = getPowerByCrood(param1,param2);
         PlayMain.self.ui._powerPart.update(_offset);
      }
      
      public function releasePowerPoint() : void
      {
         if(power > 15)
         {
            shoot();
            PlayMain.self.ui._powerPart.update(0);
            PlayMain.self.ui._powerPart.enabled = false;
         }
      }
      
      public function onClickAssit(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         rotation = rotation + (param1.target == this._assit._inc?0.25:-0.25);
      }
      
      public function onMouseDownCue(param1:MouseEvent) : void
      {
         enabled = true;
         setAssitAlhpa(0);
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(_enabled == param1)
         {
            return;
         }
         _enabled = param1;
         if(_enabled)
         {
            stage.addEventListener("mouseMove",onMouseMoveCue,false,0,true);
            stage.addEventListener("mouseUp",onMouseUpCue,false,0,true);
            stage.addEventListener("releaseOutside",onMouseUpCue,false,0,true);
         }
         else
         {
            stage.removeEventListener("mouseMove",onMouseMoveCue);
            stage.removeEventListener("mouseUp",onMouseUpCue);
            stage.removeEventListener("releaseOutside",onMouseUpCue);
         }
      }
      
      public function onMouseMoveCue(param1:MouseEvent) : void
      {
         var _loc2_:Point = new Point(param1.stageX,param1.stageY);
         _loc2_ = root.globalToLocal(_loc2_);
         rotateTo(_loc2_.x,_loc2_.y,180);
      }
      
      public function onMouseUpCue(param1:MouseEvent) : void
      {
         enabled = false;
         setAssitAlhpa(1);
      }
   }
}
