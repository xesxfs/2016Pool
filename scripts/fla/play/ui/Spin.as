package fla.play.ui
{
   import fla.play.__EW.Coord;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class Spin extends Sprite
   {
      
      private static const __b:int = 5;
      
      public static const __GK:String = "englishChanged";
       
      
      private const __AU:Number = 2;
      
      private const __Ei:Number = 29;
      
      private var __EB:Point;
      
      private var __8A:Sprite;
      
      private var __8C:Boolean = false;
      
      private var __Fm:Boolean = true;
      
      public function Spin()
      {
         __EB = new Point(0,0);
         super();
         __8A = new Sprite();
         __8A.graphics.lineStyle(2,16711680,0.5);
         __8A.graphics.drawCircle(0,0,5);
         __8A.mouseEnabled = false;
         addChild(__8A);
         reset();
         addEventListener("mouseDown",onMouseDown);
         addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         removeEventListener("removedFromStage",onRemovedFromStage);
         detachMouseUp();
      }
      
      private function detachMouseUp() : void
      {
         stage.removeEventListener("mouseMove",onMouseMove);
         stage.removeEventListener("mouseUp",onMouseUp);
         stage.removeEventListener("releaseOutside",onMouseUp);
         __8C = false;
      }
      
      private function __E6() : void
      {
         stage.addEventListener("mouseMove",onMouseMove,false,0,true);
         stage.addEventListener("mouseUp",onMouseUp,false,0,true);
         stage.addEventListener("releaseOutside",onMouseUp,false,0,true);
         __8C = true;
      }
      
      public function set __D6(param1:Number) : void
      {
         __8A.x = param1 * 29;
      }
      
      public function set __61(param1:Number) : void
      {
         __8A.y = param1 * 29;
      }
      
      public function reset() : void
      {
         __8A.x = 0;
         __8A.y = 0;
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(param1.buttonDown && !__Fm)
         {
            _loc2_ = globalToLocal(new Point(param1.stageX,param1.stageY));
            __Hb(_loc2_.x,_loc2_.y);
         }
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         detachMouseUp();
      }
      
      public function set lock(param1:Boolean) : void
      {
         if(param1 == __Fm)
         {
            return;
         }
         __Fm = param1;
         if(__Fm)
         {
            if(__8C)
            {
               detachMouseUp();
            }
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         if(__Fm || __8C)
         {
            return;
         }
         __E6();
         onMouseMove(param1);
      }
      
      public function get __D6() : Number
      {
         return __8A.x / 29;
      }
      
      public function get __61() : Number
      {
         return __8A.y / 29;
      }
      
      private function __Hb(param1:Number, param2:Number) : void
      {
         var _loc3_:Coord = new Coord();
         _loc3_.init(param1,param2);
         if(_loc3_.length > 20)
         {
            _loc3_.length = 20;
         }
         __8A.x = _loc3_.x;
         __8A.y = _loc3_.y;
         dispatchEvent(new Event("englishChanged"));
      }
   }
}
