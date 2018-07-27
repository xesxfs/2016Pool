package fla.play.__ball
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class Renderer
   {
      
      private static var __3g:uint = 16762368;
      
      private static var __HB:Bitmap = Asset.getBitmapBy(Asset.BallMaskTextureFile);
      
      private static var __7j:Bitmap = Asset.getBitmapBy(Asset.BallNumbersTextureFile);
      
      private static var __S:uint = 6492525;
      
      private static var __09:uint = 6622720;
      
      private static var __D1:uint = 2299145;
      
      private static var __Dq:uint = 414208;
      
      private static var __Aw:uint = 14357267;
      
      private static var __Cy:uint = 2704565;
      
      private static var __1F:Array = [__3g,__Cy,__Aw,__S,__EX,__Dq,__09,__D1];
      
      private static var __G6:uint = 15658195;
      
      private static var __EX:uint = 16736256;
       
      
      public function Renderer()
      {
         super();
      }
      
      public static function draw(param1:Number) : BitmapData
      {
         var _loc14_:* = 0;
         var _loc2_:* = false;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc13_:* = 0;
         var _loc9_:* = 0;
         var _loc8_:* = 0;
         var _loc11_:* = 0;
         var _loc10_:* = 0;
         var _loc12_:BitmapData = __HB.bitmapData.clone();
         if(param1 == 0)
         {
            _loc12_.fillRect(new Rectangle(0,0,_loc12_.width,_loc12_.height),__G6 | 4278190080);
         }
         else
         {
            _loc14_ = uint(0);
            _loc2_ = param1 > 8;
            _loc14_ = uint(__1F[(param1 - 1) % __1F.length]);
            _loc3_ = uint(0);
            while(_loc3_ < _loc12_.height)
            {
               _loc7_ = uint(0);
               while(_loc7_ < _loc12_.width)
               {
                  _loc13_ = uint(0);
                  if(_loc2_)
                  {
                     _loc13_ = uint((_loc12_.getPixel32(_loc7_,_loc3_) & 65280) >> 8);
                  }
                  else
                  {
                     _loc13_ = uint(_loc12_.getPixel32(_loc7_,_loc3_) & 255);
                  }
                  _loc9_ = uint(255 - _loc13_);
                  _loc8_ = uint(((_loc13_ * (_loc14_ & 16711935) & 4278255360) >> 8) + ((_loc9_ * (__G6 & 16711935) & 4278255360) >> 8));
                  _loc11_ = uint(_loc13_ * (_loc14_ & 65280) + _loc9_ * (__G6 & 65280) >> 8 & 65280);
                  _loc12_.setPixel32(_loc7_,_loc3_,_loc8_ | _loc11_ | 4278190080);
                  _loc7_++;
               }
               _loc3_++;
            }
            _loc4_ = uint((param1 - 1) * __7j.width);
            _loc5_ = uint((__HB.width - __7j.width) / 2);
            _loc6_ = uint((__HB.height - __7j.width) / 2);
            _loc3_ = uint(0);
            while(_loc3_ < __7j.width)
            {
               _loc7_ = uint(0);
               while(_loc7_ < __7j.width)
               {
                  _loc10_ = uint(_loc12_.getPixel32(_loc5_ + _loc7_,_loc6_ + _loc3_));
                  _loc13_ = uint(__7j.bitmapData.getPixel32(_loc7_,_loc4_ + _loc3_) & 255);
                  _loc9_ = uint(255 - _loc13_);
                  _loc8_ = uint(((_loc13_ * (__D1 & 16711935) & 4278255360) >> 8) + ((_loc9_ * (_loc10_ & 16711935) & 4278255360) >> 8));
                  _loc11_ = uint(_loc13_ * (__D1 & 65280) + _loc9_ * (_loc10_ & 65280) >> 8 & 65280);
                  _loc12_.setPixel32(_loc5_ + _loc7_,_loc6_ + _loc3_,_loc8_ | _loc11_ | 4278190080);
                  _loc7_++;
               }
               _loc3_++;
            }
         }
         return _loc12_;
      }
   }
}
