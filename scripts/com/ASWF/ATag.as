package com.ASWF
{
   import flash.utils.ByteArray;
   
   public class ATag
   {
       
      
      public var RECORDHEADER:_RECORDHEADER;
      
      public var data:ASwfByteArray;
      
      public var index:uint;
      
      public function ATag()
      {
         RECORDHEADER = new _RECORDHEADER();
         super();
         data = new ASwfByteArray();
         data.position = 0;
      }
      
      public function decode() : void
      {
      }
      
      public function encode(param1:Boolean = true) : ByteArray
      {
         var _loc2_:int = 0;
         var _loc3_:ASwfByteArray = new ASwfByteArray();
         if(param1 == true)
         {
            _loc2_ = data.length;
            if(_loc2_ >= 63)
            {
               RECORDHEADER.length6 = 63;
               RECORDHEADER.length32 = _loc2_;
            }
            else
            {
               RECORDHEADER.length6 = _loc2_;
               RECORDHEADER.length32 = 0;
            }
            _loc3_.writeShort(RECORDHEADER.type << 6 | RECORDHEADER.length6);
            if(RECORDHEADER.length32 != 0)
            {
               _loc3_.writeUnsignedInt(RECORDHEADER.length32);
            }
         }
         _loc3_.writeBytes(data);
         return _loc3_;
      }
   }
}

class _RECORDHEADER
{
    
   
   public var type:uint;
   
   public var length6:uint;
   
   public var length32:uint;
   
   function _RECORDHEADER()
   {
      super();
   }
}
