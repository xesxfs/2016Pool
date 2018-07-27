package fla.play.__ball
{
   import fla.play.PlayBody;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   
   public class Table#214 extends Sprite
   {
      
      private static var _self:Table#214;
       
      
      private var __7w:Object;
      
      private var __5p:BitmapData;
      
      private var ballLayerFore:Sprite;
      
      private var _visualBalls:Array;
      
      private var __FS:Loader;
      
      public var _canvas:Sprite;
      
      private var __AK:Matrix;
      
      private var ballLayerBack:Sprite;
      
      public function Table#214()
      {
         super();
         ballLayerBack = new Sprite();
         ballLayerFore = new Sprite();
         addChild(ballLayerBack);
         addChild(_canvas);
         addChild(ballLayerFore);
         _self = this;
      }
      
      public static function get instance() : Table#214
      {
         return _self;
      }
      
      private function ballChangedState(param1:BallEvent) : void
      {
         var _loc2_:VisualBall = _visualBalls[(param1.target as LogicalBall).number];
         if(param1.fromState == 1)
         {
            ballLayerFore.removeChild(_loc2_.__Hk);
            ballLayerFore.removeChild(_loc2_.__7t);
            ballLayerFore.removeChild(_loc2_.face);
            ballLayerBack.addChildAt(_loc2_.__Hk,0);
            ballLayerBack.addChild(_loc2_.face);
            ballLayerBack.addChild(_loc2_.__7t);
         }
         else if(param1.toState == 1)
         {
            ballLayerBack.removeChild(_loc2_.__Hk);
            ballLayerBack.removeChild(_loc2_.__7t);
            ballLayerBack.removeChild(_loc2_.face);
            ballLayerFore.addChildAt(_loc2_.__Hk,0);
            ballLayerFore.addChild(_loc2_.face);
            ballLayerFore.addChild(_loc2_.__7t);
         }
         _loc2_.__Hk.visible = param1.toState != 2;
      }
      
      public function get clothSource() : Object
      {
         return __7w;
      }
      
      private function __3r() : void
      {
         var _loc1_:int = (_canvas.width - __5p.width) / 2;
         var _loc2_:int = (_canvas.height - __5p.height) / 2;
         var _loc3_:Matrix = new Matrix();
         _loc3_.translate(_loc1_,_loc2_);
         _canvas.graphics.beginBitmapFill(__5p,_loc3_);
         _canvas.graphics.drawRect(_loc1_,_loc2_,__5p.width,__5p.height);
         _canvas.graphics.endFill();
      }
      
      public function get canvas() : Sprite
      {
         return _canvas;
      }
      
      public function set initBalls(param1:Vector.<LogicalBall>) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _visualBalls = [];
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].addEventListener("ballChangedState",ballChangedState);
            _visualBalls.push(new VisualBall(param1[_loc2_],Renderer.draw(_loc2_),PlayBody.centerPos));
            _loc2_++;
         }
         __AK = new Matrix();
         var _loc5_:int = 0;
         var _loc4_:* = _visualBalls;
         for each(_loc3_ in _visualBalls)
         {
            ballLayerBack.addChild(_loc3_.__Hk);
         }
         var _loc7_:int = 0;
         var _loc6_:* = _visualBalls;
         for each(_loc3_ in _visualBalls)
         {
            ballLayerBack.addChild(_loc3_.face);
            ballLayerBack.addChild(_loc3_.__7t);
         }
      }
      
      public function renderBalls() : void
      {
         FaceTool.setSize((_visualBalls[0] as VisualBall).radius);
         var _loc3_:int = 0;
         var _loc2_:* = _visualBalls;
         for each(var _loc1_ in _visualBalls)
         {
            _loc1_.renderBall();
         }
      }
      
      private function __F(param1:Event) : void
      {
         __FS.x = (_canvas.width - __FS.width) * 0.5;
         __FS.y = (_canvas.height - __FS.height) * 0.5;
         if(!_canvas.contains(__FS))
         {
            _canvas.addChild(__FS);
         }
      }
      
      private function __K(param1:Event) : void
      {
         if(_canvas.contains(__FS))
         {
            _canvas.removeChild(__FS);
         }
      }
      
      public function get visualBalls() : Array
      {
         return _visualBalls;
      }
   }
}
