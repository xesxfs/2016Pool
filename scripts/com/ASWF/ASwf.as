package com.ASWF
{
   public class ASwf
   {
       
      
      public var header:ASwfHeader;
      
      public var tags:Vector.<ATag>;
      
      public var bin:ASwfByteArray;
      
      public function ASwf()
      {
         header = new ASwfHeader();
         tags = new Vector.<ATag>();
         super();
      }
      
      public function getTagBy(param1:uint) : ATag
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < tags.length)
         {
            _loc2_ = tags[_loc3_];
            if(_loc2_.RECORDHEADER.type == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getTagsBy(param1:uint) : Vector.<ATag>
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:Vector.<ATag> = new Vector.<ATag>();
         _loc4_ = 0;
         while(_loc4_ < tags.length)
         {
            _loc3_ = tags[_loc4_];
            if(_loc3_.RECORDHEADER.type == param1)
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
   }
}
