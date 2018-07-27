package fla.play.__ball
{
   import fla.play.__EW.__FL;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class FaceBase extends Sprite
   {
      
      private static var __FU:BitmapData = Asset.getBitmapBy(Asset.BallHighlightTextureFile).bitmapData;
       
      
      protected var __5T:Number;
      
      protected var __58:Number;
      
      protected var __2L:int;
      
      private var __7s:Matrix;
      
      protected var __7V:int;
      
      protected var __DA:__FL;
      
      protected var __Gx:BitmapData;
      
      private var __17:Number;
      
      public function FaceBase(param1:int = 0, param2:int = 10, param3:__FL = null, param4:Number = 0, param5:Number = 0)
      {
         super();
         __DA = new __FL();
         if(param3 != null)
         {
            __5q = param3;
         }
         else
         {
            __DA.__50();
            __5q = __DA;
         }
         __7s = new Matrix();
         __9L = param4;
         __HR = param5;
         ballNumber = param1;
         radius = param2;
         renderBall();
      }
      
      public function get __HR() : Number
      {
         return __58;
      }
      
      public function set __HR(param1:Number) : void
      {
         __58 = param1;
      }
      
      public function get __5q() : __FL
      {
         return __DA;
      }
      
      public function set __5q(param1:__FL) : void
      {
         __DA.__4R(param1);
      }
      
      public function set ballNumber(param1:int) : void
      {
         __2L = param1;
         __Gx = Renderer.draw(__2L);
      }
      
      public function get radius() : int
      {
         return __2L;
      }
      
      public function get ballNumber() : int
      {
         return __2L;
      }
      
      public function set radius(param1:int) : void
      {
         __7V = param1;
         __17 = (1 + __7V * 2) / __FU.width;
      }
      
      public function renderBall() : void
      {
         __7s.identity();
         __7s.translate(-__FU.width / 2,-__FU.height / 2);
         __7s.scale(__17,__17);
         __7s.translate(-__9L,-__HR);
         graphics.beginBitmapFill(__FU,__7s,false,true);
         graphics.drawRect(-(__FU.width * __17) / 2,-(__FU.height * __17) / 2,__FU.width * __17,__FU.height * __17);
         graphics.endFill();
      }
      
      public function __F_(param1:Number, param2:Number) : void
      {
         x = int(param1);
         y = int(param2);
         __9L = int(param1) - param1;
         __HR = int(param2) - param2;
      }
      
      public function set __9L(param1:Number) : void
      {
         __5T = param1;
      }
      
      public function get __9L() : Number
      {
         return __5T;
      }
   }
}
