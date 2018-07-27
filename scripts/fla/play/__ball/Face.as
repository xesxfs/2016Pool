package fla.play.__ball
{
   import fla.play.__EW.__FL;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class Face extends FaceBase
   {
       
      
      protected var __1i:int;
      
      protected var _bmd:BitmapData;
      
      protected var __At:int;
      
      protected var __0w:int;
      
      protected var __Gy:int;
      
      protected var __Bi:int;
      
      protected var FaceBase:Matrix;
      
      public function Face(param1:int = 0, param2:int = 10, param3:__FL = null, param4:Number = 0, param5:Number = 0)
      {
         super(param1,param2,param3,__5T,__58);
      }
      
      override public function set radius(param1:int) : void
      {
         .super.radius = param1;
         _bmd = new BitmapData(1 + param1 * 2,1 + param1 * 2);
         __Bi = __7V * __7V;
         __1i = (__7V - 1) * (__7V - 1);
         __At = 256 / (__Bi - __1i);
         __Gy = _bmd.width / 2;
         __0w = _bmd.width / 2;
         FaceBase = new Matrix();
         FaceBase.translate(-__Gy,-__0w);
      }
      
      override public function renderBall() : void
      {
         var _loc5_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:int = 0;
         var _loc22_:Number = __Gx.width / 2;
         var _loc24_:Number = __Gx.height / 2;
         var _loc25_:Number = _bmd.width;
         var _loc11_:Number = _bmd.height;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         var _loc9_:Number = __DA.aa;
         var _loc10_:Number = __DA.ab;
         var _loc6_:Number = __DA.ac;
         var _loc23_:Number = __DA.ba;
         var _loc21_:Number = __DA.bb;
         var _loc20_:Number = __DA.bc;
         var _loc19_:Number = __DA.cc >= 0?1:-1;
         _bmd.lock();
         while(_loc18_ < _loc11_)
         {
            _loc17_ = uint(0);
            while(_loc17_ < _loc25_)
            {
               _loc5_ = _loc17_ - __7V + __5T;
               _loc2_ = _loc18_ - __7V + __58;
               _loc1_ = _loc5_ * _loc5_ + _loc2_ * _loc2_;
               if(_loc1_ < __Bi)
               {
                  _loc12_ = Number(_loc5_ / __7V);
                  _loc13_ = Number(_loc2_ / __7V);
                  _loc14_ = Number(Math.sqrt(1 - _loc12_ * _loc12_ - _loc13_ * _loc13_));
                  _loc8_ = uint(64 + _loc14_ * 191);
                  _loc15_ = Number((_loc12_ * _loc9_ + _loc13_ * _loc10_ + _loc14_ * _loc6_) * _loc19_);
                  _loc16_ = Number(_loc12_ * _loc23_ + _loc13_ * _loc21_ + _loc14_ * _loc20_);
                  _loc7_ = uint(__Gx.getPixel32(_loc22_ + _loc15_ * _loc22_,_loc24_ + _loc16_ * _loc24_));
                  _loc7_ = uint(((_loc7_ & 16711935) * _loc8_ >> 8 & 16711935) + ((_loc7_ & 65280) * _loc8_ >> 8 & 65280));
                  if(_loc1_ <= __1i)
                  {
                     _loc3_ = uint(4278190080 + _loc7_);
                  }
                  else
                  {
                     _loc4_ = uint(256 - (_loc1_ - __1i) * __At);
                     _loc3_ = uint((_loc4_ << 24) + _loc7_);
                  }
               }
               else
               {
                  _loc3_ = uint(0);
               }
               _bmd.setPixel32(_loc17_,_loc18_,_loc3_);
               _loc17_++;
            }
            _loc18_++;
         }
         _bmd.unlock();
         graphics.clear();
         graphics.beginBitmapFill(_bmd,FaceBase,false,true);
         graphics.drawRect(-__Gy,-__0w,_loc25_,_loc11_);
         graphics.endFill();
         super.renderBall();
      }
   }
}
