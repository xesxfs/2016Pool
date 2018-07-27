package
{
   import com.zip.ZipEntry;
   import com.zip.ZipFile;
   import flash.display.Loader;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class Boot
   {
      
      public static var ConfBin:Class = conf_json$cf485154535b6eb6a83f89bf4b20a4951941257262;
      
      public static var DataBin:Class = data_zip$1cc610aca784bceccb7a85fb344038051241508289;
      
      public static var ImageBin:Class = image_swf$5c0b3a5ffc6fb5284f6b04e60537dece1821235753;
      
      public static var SoundBin:Class = §sound_swf$34ef09921cc5142a467ff59e56831dff-1151459107§;
      
      private static var _imageLoader:Loader;
      
      private static var _soundLoader:Loader;
      
      private static var _loaderCount:int = 0;
       
      
      public function Boot()
      {
         super();
      }
      
      public static function init(param1:Function) : void
      {
         onCompleted = param1;
         var onCompelteLoad:Function = function():void
         {
            _loaderCount = Number(_loaderCount) + 1;
            if(_loaderCount == 2)
            {
               onCompleted();
            }
         };
         var bin:ByteArray = new ConfBin();
         var txt:String = bin.readUTFBytes(bin.length).replace(/\s+\/\/.*/g,"");
         var obj:Object = JSON.parse(txt);
         _G.conf = obj;
         unzipData(new DataBin());
         var context:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         context.allowCodeImport = true;
         _imageLoader = new Loader();
         _imageLoader.contentLoaderInfo.addEventListener("complete",onCompelteLoad);
         _imageLoader.loadBytes(new ImageBin(),context);
         _soundLoader = new Loader();
         _soundLoader.contentLoaderInfo.addEventListener("complete",onCompelteLoad);
         _soundLoader.loadBytes(new SoundBin(),context);
      }
      
      private static function unzipData(param1:ByteArray) : void
      {
         var _loc12_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc11_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc10_:* = null;
         var _loc2_:ZipFile = new ZipFile(param1);
         var _loc6_:Array = _loc2_.entries;
         _loc12_ = 0;
         _loc9_ = _loc6_.length;
         while(_loc12_ < _loc9_)
         {
            _loc7_ = _loc6_[_loc12_];
            _loc8_ = _loc7_.name;
            _loc11_ = _loc8_.split(".");
            _loc5_ = _loc11_[0];
            _loc3_ = _loc11_[1];
            _loc4_ = _loc2_.getInput(_loc7_);
            if(_loc4_.length)
            {
               _loc10_ = _loc4_.readUTFBytes(_loc4_.length);
               _G.fc.csv.addCsvFile(_loc5_,_loc10_);
            }
            _loc12_++;
         }
      }
   }
}
