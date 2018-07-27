package fla.play.__ball
{
   import fla.play.PlayMain;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   
   public class VisualBall extends EventDispatcher
   {
      
      public static const DRAG_END:String = "visualBallDraggedEnd";
      
      public static const DRAGING:String = "visualBallDragged";
      
      public static const DRAG_BEGIN:String = "visualBallDraggedBegin";
       
      
      private var __1O:Sprite;
      
      private var _size:Number;
      
      private var _face:FaceBase;
      
      private var _logicBall:LogicalBall;
      
      private var __F3:BitmapData;
      
      private var _positionMask:Sprite;
      
      private var _position:Position;
      
      private var __BM:Sprite;
      
      public function VisualBall(param1:LogicalBall, param2:BitmapData, param3:Position)
      {
         super();
         _position = param3;
         _logicBall = param1;
         _logicBall.addEventListener("ballUpdated",onBallUpdated);
         _size = param3.__A2(_logicBall.radius) + 0.5;
         var _loc4_:BitmapData = Asset.getBitmapBy(Asset.ShadowBitmapFile).bitmapData;
         var _loc5_:BitmapData = Asset.getBitmapBy(Asset.HighlightBitmapFile).bitmapData;
         var _loc6_:Matrix = new Matrix();
         __F3 = new BitmapData(Math.ceil(_size * 2),Math.ceil(_size * 2),true,4294967295);
         _loc6_.identity();
         _loc6_.translate(-_loc4_.width / 2,-_loc4_.height / 2);
         __BM = new Sprite();
         __BM.graphics.beginBitmapFill(_loc4_,_loc6_,false,true);
         __BM.graphics.drawRect(-_loc4_.width / 2,-_loc4_.height / 2,_loc4_.width,_loc4_.height);
         __BM.graphics.endFill();
         _face = new Face(_logicBall.number,_size);
         _loc6_.identity();
         _loc6_.translate(-_loc5_.width / 2,-_loc5_.height / 2);
         __1O = new Sprite();
         _positionMask = new Sprite();
         _positionMask.graphics.beginFill(16777215,1);
         _positionMask.graphics.drawCircle(0,0,_size + 12);
         _positionMask.graphics.endFill();
         _positionMask.visible = false;
         _positionMask.alpha = 0;
         _positionMask.buttonMode = true;
         _positionMask.useHandCursor = true;
         _positionMask.addEventListener("mouseDown",onMouseDownPreMove,false,0,true);
         _logicBall.addEventListener("ballMovableStateChanged",ballMovableStateChanged);
      }
      
      public function get __Hk() : Sprite
      {
         return __BM;
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("visualBallDragged"));
      }
      
      private function onMouseDownPreMove(param1:MouseEvent) : void
      {
         _positionMask.alpha = 0.5;
         PlayMain.self.addEventListener("mouseMove",onMouseMove,false,0,true);
         PlayMain.self.addEventListener("mouseUp",onMouseUp,false,0,true);
         PlayMain.self.addEventListener("releaseOutside",onMouseUp,false,0,true);
         dispatchEvent(new Event("visualBallDraggedBegin"));
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         _positionMask.alpha = 0;
         PlayMain.self.removeEventListener("mouseMove",onMouseMove);
         PlayMain.self.removeEventListener("mouseUp",onMouseUp);
         PlayMain.self.removeEventListener("releaseOutside",onMouseUp);
         dispatchEvent(new Event("visualBallDraggedEnd"));
      }
      
      public function get __7t() : Sprite
      {
         return __1O;
      }
      
      public function get radius() : Number
      {
         return _size;
      }
      
      public function get face() : Sprite
      {
         return _face;
      }
      
      public function get logicalBall() : LogicalBall
      {
         return _logicBall;
      }
      
      public function ballMovableStateChanged(param1:Event) : void
      {
         _positionMask.visible = _logicBall.movable;
      }
      
      public function renderBall() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(_logicBall._update)
         {
            _logicBall._update = false;
            _loc4_ = _position.getVisualXPosition(_logicBall.position.x);
            _loc5_ = _position.getVisualYPosition(_logicBall.position.y);
            _loc6_ = _loc4_;
            _loc1_ = _loc5_;
            _loc2_ = 1 - (_loc4_ - _loc6_);
            _loc3_ = 1 - (_loc5_ - _loc1_);
            _face.__5q = _logicBall.rotation;
            _face.__9L = _loc2_;
            _face.__HR = _loc3_;
            _face.renderBall();
            _face.x = _loc6_;
            _face.y = _loc1_;
            __1O.x = _loc4_;
            __1O.y = _loc5_;
            _positionMask.x = _loc4_;
            _positionMask.y = _loc5_;
            if(_logicBall.state == 1)
            {
               _loc4_ = _position.getVisualXPosition(_logicBall.position.x * 1.01);
               _loc5_ = _position.getVisualYPosition(_logicBall.position.y * 1.01);
            }
            __BM.x = _loc4_;
            __BM.y = _loc5_;
         }
      }
      
      public function get ballInHandSprite() : Sprite
      {
         return _positionMask;
      }
      
      public function onBallUpdated(param1:Event) : void
      {
         FaceTool.setSize(_size);
         renderBall();
      }
   }
}
