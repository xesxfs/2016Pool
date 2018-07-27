package com.ASWF
{
   public class ATagConfig
   {
       
      
      public var introduce:String;
      
      public var decode:Boolean = false;
      
      public var mapper:Class;
      
      public function ATagConfig()
      {
         mapper = ATag;
         super();
      }
   }
}
