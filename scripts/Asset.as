package
{
   import com.adobe.images.PNGDecoder;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class Asset
   {
      
      public static var BallNumbersTextureFile:Class = §BallNumbersTexture_png$13c4b1dd007f01f6cc04229bd0ce5fe2-488279962§;
      
      public static var BallHighlightTextureFile:Class = §BallHighlightTexture_png$9d5b8c9c058b83b2d89208822efa02c3-195731320§;
      
      public static var BallMaskTextureFile:Class = §BallMaskTexture_png$e12ef720802680e1ad72b4af60d2d531-1307098718§;
      
      public static var HighlightBitmapFile:Class = HighlightBitmap_png$b04f225c9a81f6b22f5bd53b7f21da852143494423;
      
      public static var LogicalBallSlot__1File:Class = LogicalBallSlot__1_png$0290b1c84a40b9b76c63040d80a7b5552051365475;
      
      public static var LogicalBallSlot__2File:Class = LogicalBallSlot__2_png$4b990947c8b9186305a01df91420e2f52052502242;
      
      public static var CueTextureFile:Class = §CueTexture_png$066412a06dfa0119742c6aef9cd503ed-1196514418§;
      
      public static var ShadowBitmapFile:Class = ShadowBitmap_png$6fa715fec82587912c95571750e6660f532134535;
      
      private static var bmps:Dictionary = new Dictionary();
       
      
      public function Asset()
      {
         super();
      }
      
      public static function init() : void
      {
         bmps[BallNumbersTextureFile] = getBitmapBy(BallNumbersTextureFile);
         bmps[BallHighlightTextureFile] = getBitmapBy(BallHighlightTextureFile);
         bmps[BallMaskTextureFile] = getBitmapBy(BallMaskTextureFile);
         bmps[HighlightBitmapFile] = getBitmapBy(HighlightBitmapFile);
         bmps[LogicalBallSlot__1File] = getBitmapBy(LogicalBallSlot__1File);
         bmps[LogicalBallSlot__2File] = getBitmapBy(LogicalBallSlot__2File);
         bmps[CueTextureFile] = getBitmapBy(CueTextureFile);
         bmps[ShadowBitmapFile] = getBitmapBy(ShadowBitmapFile);
      }
      
      public static function getBitmapBy(param1:Class) : Bitmap
      {
         if(param1 in bmps)
         {
            return bmps[param1];
         }
         var _loc4_:ByteArray = new param1();
         var _loc3_:BitmapData = PNGDecoder.decodeImage(_loc4_);
         var _loc2_:Bitmap = new Bitmap(_loc3_);
         return _loc2_;
      }
   }
}
