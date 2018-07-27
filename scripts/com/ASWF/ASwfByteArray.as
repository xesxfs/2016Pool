package com.ASWF
{
   import flash.utils.ByteArray;
   
   public class ASwfByteArray extends ByteArray
   {
       
      
      private var bitPosR:int = 0;
      
      private var bitByteR:int = 0;
      
      private var bitPosW:int = 8;
      
      private var bitByteW:uint = 0;
      
      public function ASwfByteArray()
      {
         super();
         this.endian = "littleEndian";
      }
      
      public function readUBits(param1:int) : uint
      {
         var _loc4_:int = 0;
         if(param1 == 0)
         {
            return 0;
         }
         var _loc2_:* = param1;
         var _loc3_:uint = 0;
         if(bitPosR == 0)
         {
            bitByteR = readUnsignedByte();
            bitPosR = 8;
         }
         while(true)
         {
            _loc4_ = _loc2_ - bitPosR;
            if(_loc4_ > 0)
            {
               _loc3_ = _loc3_ | bitByteR << _loc4_;
               _loc2_ = int(_loc2_ - bitPosR);
               bitByteR = readUnsignedByte();
               bitPosR = 8;
               continue;
            }
            break;
         }
         _loc3_ = _loc3_ | bitByteR >> -_loc4_;
         bitPosR = bitPosR - _loc2_;
         bitByteR = bitByteR & 255 >> 8 - bitPosR;
         return _loc3_;
      }
      
      public function readSBits(param1:int) : int
      {
         var _loc2_:uint = readUBits(param1);
         var _loc3_:int = 32 - param1;
         _loc2_ = _loc2_ << _loc3_ >> _loc3_;
         return _loc2_;
      }
      
      public function syncBits() : void
      {
         bitPosR = 0;
      }
      
      public function writeUBits(param1:uint, param2:uint) : void
      {
         param1 >= 0 && param1 <= (1 << param2) - 1;
         writeBits(param1,param2);
      }
      
      public function writeSBits(param1:int, param2:int) : void
      {
         param1 >= -(1 << param2 - 1) && param1 <= (1 << param2 - 1) - 1;
         writeBits(param1,param2);
      }
      
      public function writeBits(param1:int, param2:int) : void
      {
         while(param2 > 0)
         {
            if(param2 > bitPosW)
            {
               bitByteW = bitByteW | param1 << 32 - param2 >>> 32 - bitPosW;
               this.writeByte(bitByteW);
               param2 = param2 - bitPosW;
               bitByteW = 0;
               bitPosW = 8;
            }
            else
            {
               bitByteW = bitByteW | param1 << 32 - param2 >>> 32 - bitPosW;
               bitPosW = bitPosW - param2;
               param2 = 0;
               if(bitPosW == 0)
               {
                  this.writeByte(bitByteW);
                  bitByteW = 0;
                  bitPosW = 8;
               }
            }
         }
      }
      
      public function flushBits() : void
      {
         if(bitPosW != 8)
         {
            this.writeByte(bitByteW);
            bitByteW = 0;
            bitPosW = 8;
         }
      }
      
      public function readU8() : uint
      {
         return readUnsignedByte();
      }
      
      public function readU16() : uint
      {
         return readUnsignedShort();
      }
      
      public function readU8String(param1:uint) : String
      {
         return readUTFBytes(param1);
      }
      
      public function readU30() : uint
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:int = 0;
         var _loc1_:uint = 128;
         _loc4_ = 0;
         while(_loc4_ < 35 && _loc1_)
         {
            _loc2_ = uint(readUnsignedByte());
            _loc1_ = _loc2_ & 128;
            _loc3_ = uint(_loc3_ | (_loc2_ & 127) << _loc4_);
            _loc4_ = _loc4_ + 7;
         }
         _loc3_ = uint(_loc3_ & 1073741823);
         return _loc3_;
      }
      
      public function readU32() : uint
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:int = 0;
         var _loc1_:uint = 128;
         _loc4_ = 0;
         while(_loc4_ < 35 && _loc1_)
         {
            _loc2_ = uint(readUnsignedByte());
            _loc1_ = _loc2_ & 128;
            _loc3_ = uint(_loc3_ | (_loc2_ & 127) << _loc4_);
            _loc4_ = _loc4_ + 7;
         }
         return _loc3_;
      }
      
      public function readUI32() : uint
      {
         return readUnsignedInt();
      }
      
      public function readS32() : int
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:int = 0;
         var _loc1_:uint = 128;
         _loc4_ = 0;
         while(_loc4_ < 35 && _loc1_)
         {
            _loc2_ = uint(readUnsignedByte());
            _loc1_ = _loc2_ & 128;
            _loc3_ = uint(_loc3_ | (_loc2_ & 127) << _loc4_);
            _loc4_ = _loc4_ + 7;
         }
         _loc3_ = uint(_loc3_ & 2147483647);
         _loc3_ = uint(_loc3_ | (_loc2_ & 128) << 24);
         return _loc3_;
      }
      
      public function readD64() : Number
      {
         return readDouble();
      }
      
      public function readSTRING() : String
      {
         var _loc1_:int = position;
         var _loc2_:* = _loc1_;
         while(this[_loc2_] != 0)
         {
            _loc2_ = int(_loc2_ + 1);
         }
         _loc2_ = int(_loc2_ + 1);
         return readUTFBytes(_loc2_ - _loc1_);
      }
      
      public function writeU8(param1:uint) : void
      {
         return writeByte(param1);
      }
      
      public function writeU16(param1:uint) : void
      {
         return writeShort(param1);
      }
      
      public function writeU8String(param1:String) : void
      {
         return writeUTFBytes(param1);
      }
      
      public function writeU30(param1:uint) : void
      {
         var _loc3_:* = 0;
         var _loc6_:int = 0;
         param1 = param1 & 1073741823;
         var _loc2_:uint = 128;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc6_ = 0;
         while(_loc6_ < 35 && _loc2_)
         {
            _loc4_ = 127 << _loc6_;
            _loc5_ = _loc5_ | _loc4_;
            _loc3_ = uint((param1 & _loc4_) >> _loc6_);
            _loc2_ = param1 > _loc5_?128:0;
            _loc3_ = uint(_loc3_ | _loc2_);
            writeByte(_loc3_);
            _loc6_ = _loc6_ + 7;
         }
      }
      
      public function writeU32(param1:uint) : void
      {
         var _loc3_:* = 0;
         var _loc6_:int = 0;
         var _loc2_:uint = 128;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc6_ = 0;
         while(_loc6_ < 35 && _loc2_)
         {
            _loc4_ = 127 << _loc6_;
            _loc5_ = _loc5_ | _loc4_;
            _loc3_ = uint((param1 & _loc4_) >> _loc6_);
            _loc2_ = param1 > _loc5_?128:0;
            _loc3_ = uint(_loc3_ | _loc2_);
            writeByte(_loc3_);
            _loc6_ = _loc6_ + 7;
         }
      }
      
      public function writeUI32(param1:uint) : void
      {
         return writeUnsignedInt(param1);
      }
      
      public function writeS32(param1:int) : void
      {
         var _loc4_:* = 0;
         var _loc7_:int = 0;
         var _loc2_:uint = param1 >= 0?0:Number(128);
         param1 = param1 & 2147483647;
         var _loc3_:* = uint(128);
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc7_ = 0;
         while(_loc7_ < 35 && _loc3_)
         {
            _loc5_ = 127 << _loc7_;
            _loc6_ = _loc6_ | _loc5_;
            _loc4_ = uint((param1 & _loc5_) >> _loc7_);
            _loc3_ = uint(param1 > _loc6_?128:0);
            if(_loc3_ == 0)
            {
               _loc3_ = _loc2_;
            }
            _loc4_ = uint(_loc4_ | _loc3_);
            writeByte(_loc4_);
            _loc7_ = _loc7_ + 7;
         }
      }
      
      public function writeD64(param1:Number) : void
      {
         return writeDouble(param1);
      }
      
      public function writeSTRING(param1:String) : void
      {
         writeUTFBytes(param1);
         writeByte(0);
      }
      
      public function pack() : void
      {
         this[0] = 67;
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeBytes(this,8);
         _loc1_.compress();
         this.length = 8;
         this.position = this.length;
         this.writeBytes(_loc1_);
      }
   }
}
