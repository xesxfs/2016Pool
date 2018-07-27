package com.ASWF
{
   public class ASwfHeader
   {
       
      
      public var compressed:uint;
      
      public var signedByte1:uint;
      
      public var singedByte2:uint;
      
      public var version:uint;
      
      public var fileLength:uint;
      
      public var frameSize:RECT;
      
      public var frameRate:uint;
      
      public var frameCount:uint;
      
      public var length:int;
      
      public var swfWidth:int;
      
      public var swfHeight:int;
      
      public function ASwfHeader()
      {
         frameSize = new RECT();
         super();
      }
   }
}

class RECT
{
    
   
   public var NBits:uint;
   
   public var xMin:uint;
   
   public var xMax:uint;
   
   public var yMin:uint;
   
   public var yMax:uint;
   
   function RECT()
   {
      super();
   }
}
