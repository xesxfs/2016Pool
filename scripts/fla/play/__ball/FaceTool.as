package fla.play.__ball
{
   import fla.play.__EW.__FL;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class FaceTool
   {
      
      private static var __t:Number;
      
      private static var __Gr:Number;
      
      private static var __2C:ByteArray = new ByteArray();
      
      private static var __F9:Number;
      
      private static var __V:Number;
      
      private static var __Cc:Number;
       
      
      public function FaceTool()
      {
         super();
      }
      
      public static function __Ds(param1:BitmapData = null, param2:Number = 0, param3:Number = 0) : BitmapData
      {
         var _loc14_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc13_:* = 0;
         var _loc15_:* = 0;
         var _loc12_:int = 0;
         var _loc4_:BitmapData = param1 == null?new BitmapData(__V,__V):param1;
         var _loc5_:Number = _loc4_.width;
         var _loc6_:Number = _loc4_.height;
         __2C.position = 0;
         while(_loc12_ < _loc6_)
         {
            _loc15_ = uint(0);
            while(_loc15_ < _loc5_)
            {
               _loc14_ = _loc15_ - __t + param2;
               _loc11_ = _loc12_ - __t + param3;
               _loc10_ = Math.sqrt(_loc14_ * _loc14_ + _loc11_ * _loc11_);
               if(_loc10_ < __t)
               {
                  if(_loc10_ <= __t - 1)
                  {
                     __2C.writeUnsignedInt(4294967295);
                  }
                  else
                  {
                     _loc13_ = uint(256 * (__t - _loc10_));
                     __2C.writeUnsignedInt(-16777216 + (_loc13_ << 16) + (_loc13_ << 8) + _loc13_);
                  }
               }
               else
               {
                  __2C.writeUnsignedInt(0);
               }
               _loc15_++;
            }
            _loc12_++;
         }
         __2C.position = 0;
         _loc4_.setPixels(new Rectangle(0,0,_loc4_.width,_loc4_.height),__2C);
         return _loc4_;
      }
      
      public static function setSize(param1:Number) : void
      {
         if(__t != param1)
         {
            __t = param1;
            __V = __t * 2;
            __Gr = param1 * param1;
            __F9 = (param1 - 1) * (param1 - 1);
            __Cc = 256 / (__Gr - __F9);
         }
      }
      
      public static function drawByData(param1:BitmapData, param2:BitmapData = null, param3:__FL = null, param4:Number = 0, param5:Number = 0) : BitmapData
      {
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc13_:* = 0;
         var _loc27_:* = 0;
         var _loc26_:* = 0;
         var _loc25_:* = 0;
         var _loc10_:* = 0;
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         var _loc18_:BitmapData = param2 == null?new BitmapData(__V,__V):param2;
         var _loc19_:Number = param1.width / 2;
         var _loc20_:Number = param1.height / 2;
         var _loc21_:Number = _loc18_.width;
         var _loc12_:Number = _loc18_.height;
         var _loc8_:* = 0;
         var _loc7_:* = 0;
         var _loc11_:* = 0;
         var _loc9_:* = 0;
         var _loc14_:* = 0;
         var _loc24_:* = 1;
         var _loc23_:* = 0;
         var _loc22_:* = 0;
         var _loc30_:* = 0;
         var _loc31_:* = 1;
         var _loc28_:* = 0;
         if(param3 != null)
         {
            _loc24_ = Number(param3.aa);
            _loc23_ = Number(param3.ab);
            _loc22_ = Number(param3.ac);
            _loc30_ = Number(param3.ba);
            _loc31_ = Number(param3.bb);
            _loc28_ = Number(param3.bc);
         }
         var _loc29_:Number = param3 == null || param3.cc >= 0?1:-1;
         _loc18_.lock();
         while(_loc6_ < _loc12_)
         {
            _loc10_ = uint(0);
            while(_loc10_ < _loc21_)
            {
               _loc15_ = _loc10_ - __t + param4;
               _loc16_ = _loc6_ - __t + param5;
               _loc17_ = _loc15_ * _loc15_ + _loc16_ * _loc16_;
               if(_loc17_ < __Gr)
               {
                  _loc8_ = Number(_loc15_ / __t);
                  _loc7_ = Number(_loc16_ / __t);
                  _loc11_ = Number(Math.sqrt(1 - _loc8_ * _loc8_ - _loc7_ * _loc7_));
                  _loc25_ = uint(64 + _loc11_ * 191);
                  _loc9_ = Number((_loc8_ * _loc24_ + _loc7_ * _loc23_ + _loc11_ * _loc22_) * _loc29_);
                  _loc14_ = Number(_loc8_ * _loc30_ + _loc7_ * _loc31_ + _loc11_ * _loc28_);
                  _loc26_ = uint(param1.getPixel32(_loc19_ + _loc9_ * _loc19_,_loc20_ + _loc14_ * _loc20_));
                  _loc26_ = uint(((_loc26_ & 16711935) * _loc25_ >> 8 & 16711935) + ((_loc26_ & 65280) * _loc25_ >> 8 & 65280));
                  if(_loc17_ <= __F9)
                  {
                     _loc27_ = uint(4278190080 + _loc26_);
                  }
                  else
                  {
                     _loc13_ = uint(256 - (_loc17_ - __F9) * __Cc);
                     _loc27_ = uint((_loc13_ << 24) + _loc26_);
                  }
               }
               else
               {
                  _loc27_ = uint(0);
               }
               _loc18_.setPixel32(_loc10_,_loc6_,_loc27_);
               _loc10_++;
            }
            _loc6_++;
         }
         _loc18_.unlock();
         return _loc18_;
      }
      
      public static function __CO(param1:BitmapData, param2:BitmapData = null, param3:__FL = null, param4:Number = 0, param5:Number = 0) : BitmapData
      {
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc13_:* = 0;
         var _loc26_:* = 0;
         var _loc25_:* = 0;
         var _loc10_:* = 0;
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         var _loc18_:BitmapData = param2 == null?new BitmapData(__V,__V):param2;
         var _loc19_:Number = param1.width / 2;
         var _loc20_:Number = param1.height / 2;
         var _loc21_:Number = _loc18_.width;
         var _loc12_:Number = _loc18_.height;
         var _loc8_:* = 0;
         var _loc7_:* = 0;
         var _loc11_:* = 0;
         var _loc9_:* = 0;
         var _loc14_:* = 0;
         var _loc24_:* = 1;
         var _loc23_:* = 0;
         var _loc22_:* = 0;
         var _loc30_:* = 0;
         var _loc31_:* = 1;
         var _loc28_:* = 0;
         if(param3 != null)
         {
            _loc24_ = Number(param3.aa);
            _loc23_ = Number(param3.ab);
            _loc22_ = Number(param3.ac);
            _loc30_ = Number(param3.ba);
            _loc31_ = Number(param3.bb);
            _loc28_ = Number(param3.bc);
         }
         var _loc29_:Number = param3 == null || param3.cc >= 0?1:-1;
         __2C.position = 0;
         while(_loc6_ < _loc12_)
         {
            _loc10_ = uint(0);
            while(_loc10_ < _loc21_)
            {
               _loc15_ = _loc10_ - __t + param4;
               _loc16_ = _loc6_ - __t + param5;
               _loc17_ = _loc15_ * _loc15_ + _loc16_ * _loc16_;
               if(_loc17_ < __Gr)
               {
                  _loc8_ = Number(_loc15_ / __t);
                  _loc7_ = Number(_loc16_ / __t);
                  _loc11_ = Number(Math.sqrt(1 - _loc8_ * _loc8_ - _loc7_ * _loc7_));
                  _loc25_ = uint(64 + _loc11_ * 191);
                  _loc9_ = Number((_loc8_ * _loc24_ + _loc7_ * _loc23_ + _loc11_ * _loc22_) * _loc29_);
                  _loc14_ = Number(_loc8_ * _loc30_ + _loc7_ * _loc31_ + _loc11_ * _loc28_);
                  _loc26_ = uint(param1.getPixel32(_loc19_ + _loc9_ * _loc19_,_loc20_ + _loc14_ * _loc20_));
                  _loc26_ = uint(((_loc26_ & 16711935) * _loc25_ >> 8 & 16711935) + ((_loc26_ & 65280) * _loc25_ >> 8 & 65280));
                  if(_loc17_ <= __F9)
                  {
                     __2C.writeUnsignedInt(4278190080 + _loc26_);
                  }
                  else
                  {
                     _loc13_ = uint(256 - (_loc17_ - __F9) * __Cc);
                     __2C.writeUnsignedInt((_loc13_ << 24) + _loc26_);
                  }
               }
               else
               {
                  __2C.writeUnsignedInt(0);
               }
               _loc10_++;
            }
            _loc6_++;
         }
         __2C.position = 0;
         _loc18_.setPixels(new Rectangle(0,0,param1.width,param1.height),__2C);
         return _loc18_;
      }
      
      public static function drawByNo(param1:int, param2:BitmapData = null, param3:__FL = null, param4:Number = 0, param5:Number = 0) : BitmapData
      {
         return drawByData(Renderer.draw(param1),param2,param3,param4,param5);
      }
   }
}
