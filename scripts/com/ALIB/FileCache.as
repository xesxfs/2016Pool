package com.ALIB
{
   import com.zip.ZipEntry;
   import com.zip.ZipFile;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class FileCache
   {
      
      public static const LOAD_COMPLETE:int = 1;
      
      public static const LOAD_FAIL:int = 2;
      
      public static const LOADING:int = 4;
      
      public static const DECODE:int = 8;
      
      public static const ONLY_BIN:int = 16;
      
      public static var onCompleteDownload:Function;
       
      
      public var urlPrefix:String = "";
      
      private var _caches:Dictionary;
      
      private var _channels:Dictionary;
      
      public var csv:CsvDatabase;
      
      public function FileCache()
      {
         _caches = new Dictionary();
         _channels = new Dictionary();
         csv = new CsvDatabase();
         super();
      }
      
      public function gc(param1:int = 900000) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = getTimer();
         var _loc6_:int = 0;
         var _loc5_:* = _caches;
         for(var _loc4_ in _caches)
         {
            _loc2_ = _caches[_loc4_];
            if(_loc3_ - _loc2_.ms >= param1)
            {
               delete _caches[_loc4_];
            }
         }
      }
      
      private function addCache(param1:String, param2:String, param3:*, param4:int) : void
      {
         var _loc5_:Cache = new Cache();
         _loc5_.url = param1;
         _loc5_.name = param2;
         _loc5_.file = param3;
         _loc5_.ms = param4 || int(getTimer());
         _caches[param1] = _loc5_;
      }
      
      public function getCacheByUrl(param1:String) : Cache
      {
         return _caches[param1];
      }
      
      public function getCacheByName(param1:String) : Cache
      {
         var _loc4_:int = 0;
         var _loc3_:* = _caches;
         for each(var _loc2_ in _caches)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function updateTimestamp(param1:String) : void
      {
         var _loc2_:Cache = _caches[param1];
         if(_loc2_.ms == 2147483647)
         {
            return;
         }
         _loc2_.ms = getTimer();
      }
      
      public function getFileByName(param1:String) : *
      {
         var _loc2_:Cache = getCacheByName(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         updateTimestamp(_loc2_.url);
         return _loc2_.file;
      }
      
      public function getClassByName(param1:String, param2:String) : *
      {
         var _loc3_:Cache = getCacheByName(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         updateTimestamp(_loc3_.url);
         var _loc4_:ApplicationDomain = _loc3_.file.applicationDomain;
         return _loc4_.getDefinition(param2);
      }
      
      public function getClassByUrl(param1:String, param2:String) : *
      {
         var _loc3_:Cache = getCacheByUrl(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         updateTimestamp(_loc3_.url);
         var _loc4_:ApplicationDomain = _loc3_.file.applicationDomain;
         return _loc4_.getDefinition(param2);
      }
      
      public function getInstanceByName(param1:String, param2:String) : *
      {
         return new getClassByName(param1,param2)();
      }
      
      public function getInstanceByUrl(param1:String, param2:String) : *
      {
         return new getClassByUrl(param1,param2)();
      }
      
      public function downloadImage(param1:String, param2:Boolean = false) : Sprite
      {
         url = param1;
         cacheFromName = param2;
         var image:Sprite = new Sprite();
         var onLoad:Function = function(param1:int, param2:*):void
         {
            if(param1 != 1)
            {
               return;
            }
            var _loc3_:Bitmap = new Bitmap(param2);
            _loc3_.smoothing = true;
            image.addChild(_loc3_);
         };
         download(url,onLoad,1 | 2,cacheFromName);
         return image;
      }
      
      public function download(param1:String, param2:Function, param3:int, param4:Boolean = false) : void
      {
         url = param1;
         handle = param2;
         mask = param3;
         cacheFromName = param4;
         var last:String = url.split("/").pop();
         var name:String = last.split("?").shift();
         var type:String = name.split(".").pop();
         var cache:Cache = !!cacheFromName?getCacheByName(name):getCacheByUrl(url);
         if(cache != null)
         {
            updateTimestamp(cache.url);
            return;
            §§push(handle(1,cache.file));
         }
         else
         {
            var onLoadComplete:Function = function(param1:Event):void
            {
               var _loc2_:* = null;
               var _loc6_:* = null;
               var _loc7_:* = null;
               var _loc8_:* = null;
               var _loc10_:* = null;
               var _loc5_:* = null;
               var _loc3_:* = null;
               var _loc4_:* = null;
               var _loc9_:* = null;
               loader.removeEventListener("complete",onLoadComplete);
               loader.removeEventListener("ioError",onLoadFail);
               loader.removeEventListener("securityError",onLoadFail);
               loader.removeEventListener("progress",onLoading);
               okay = true;
               data = loader.data;
               if(onCompleteDownload != null)
               {
                  onCompleteDownload(type,data);
               }
               var _loc13_:* = type;
               if("swf" !== _loc13_)
               {
                  if("png" !== _loc13_)
                  {
                     if("jpg" !== _loc13_)
                     {
                        if("gif" !== _loc13_)
                        {
                           if("csv" !== _loc13_)
                           {
                              if("xml" !== _loc13_)
                              {
                                 if("bin" !== _loc13_)
                                 {
                                    if("zip" !== _loc13_)
                                    {
                                       if("json" !== _loc13_)
                                       {
                                          if("txt" !== _loc13_)
                                          {
                                             throw new Error("unknow file type!");
                                          }
                                          file = data.readUTFBytes(data.length);
                                          addCache(url,name,file,timestamp);
                                       }
                                       else
                                       {
                                          file = data.readUTFBytes(data.length).replace(/\s+\/\/.*/g,"");
                                          try
                                          {
                                             file = JSON.parse(file);
                                          }
                                          catch(error:SyntaxError)
                                          {
                                             throw new Error(url + ":" + error.message);
                                          }
                                          addCache(url,name,file,timestamp);
                                       }
                                    }
                                    else
                                    {
                                       _loc2_ = new ZipFile(data);
                                       _loc6_ = _loc2_.entries;
                                       i = 0;
                                       len = _loc6_.length;
                                       _loc6_.length;
                                       while(i < len)
                                       {
                                          _loc7_ = _loc6_[i];
                                          _loc8_ = _loc7_.name;
                                          _loc10_ = _loc8_.split(".");
                                          _loc5_ = _loc10_[0];
                                          _loc3_ = _loc10_[1];
                                          _loc4_ = _loc2_.getInput(_loc7_);
                                          if(_loc4_.length)
                                          {
                                             if(_loc3_ == "csv")
                                             {
                                                _loc9_ = _loc4_.readMultiByte(_loc4_.length,"gb2312");
                                                csv.addCsvFile(_loc5_,_loc9_);
                                             }
                                             else if(_loc3_ == "json")
                                             {
                                                _loc9_ = _loc4_.readUTFBytes(_loc4_.length);
                                                _loc9_ = _loc9_.replace(/\s+\/\/.*/g,"");
                                                addCache(_loc8_,_loc8_,JSON.parse(_loc9_),2147483647);
                                             }
                                             else
                                             {
                                                throw new Error("unknow zip file type:" + _loc3_);
                                             }
                                          }
                                          i = Number(i) + 1;
                                       }
                                    }
                                 }
                                 else
                                 {
                                    file = data;
                                    addCache(url,name,file,timestamp);
                                 }
                              }
                              else
                              {
                                 file = new XML(data);
                                 addCache(url,name,file,timestamp);
                              }
                           }
                           else
                           {
                              csv.addCsvFile(name.substring(0,name.length - 4),data.readMultiByte(data.length,"gb2312"));
                           }
                        }
                     }
                     addr108:
                     loaderContext = new LoaderContext();
                     loaderContext.allowCodeImport = true;
                     temp = new Loader();
                     temp.contentLoaderInfo.addEventListener("complete",onImgComplete);
                     temp.loadBytes(data,loaderContext);
                     okay = false;
                  }
                  §§goto(addr108);
               }
               else if(mask & 16)
               {
                  file = data;
                  addCache(url,name,file,timestamp);
                  okay = true;
               }
               else
               {
                  loaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
                  loaderContext.allowCodeImport = true;
                  temp = new Loader();
                  temp.contentLoaderInfo.addEventListener("complete",onSwfComplete);
                  temp.loadBytes(data,loaderContext);
                  okay = false;
               }
               if(okay)
               {
                  handle(1,file);
               }
            };
            var onLoadFail:Function = function(param1:Event):void
            {
               loader.removeEventListener("complete",onLoadComplete);
               loader.removeEventListener("ioError",onLoadFail);
               loader.removeEventListener("securityError",onLoadFail);
               loader.removeEventListener("progress",onLoading);
            };
            var onLoading:Function = function(param1:ProgressEvent):void
            {
            };
            var onSwfComplete:Function = function(param1:Event):void
            {
               param1.target.removeEventListener("complete",onSwfComplete);
               file = param1.target;
               addCache(url,name,file,timestamp);
            };
            var onImgComplete:Function = function(param1:Event):void
            {
               param1.target.removeEventListener("complete",onSwfComplete);
               file = new BitmapData(temp.content.width,temp.height,true,0);
               file.draw(temp);
               addCache(url,name,file,timestamp);
            };
            var timestamp:int = url.indexOf("_mc=-1") != -1?2147483647:0;
            var request:URLRequest = new URLRequest(urlPrefix + url);
            var loader:URLLoader = new URLLoader();
            loader.dataFormat = "binary";
            if((mask & 1) == 1)
            {
               loader.addEventListener("complete",onLoadComplete);
            }
            if((mask & 2) == 2)
            {
               loader.addEventListener("ioError",onLoadFail);
               loader.addEventListener("securityError",onLoadFail);
            }
            if((mask & 4) == 4)
            {
               loader.addEventListener("progress",onLoading);
            }
            loader.load(request);
            return;
         }
      }
      
      public function multiDownload(param1:Array, param2:Function, param3:int, param4:Boolean = false) : void
      {
         urls = param1;
         handle = param2;
         mask = param3;
         cacheFromName = param4;
         var copy:Array = urls.concat();
         var fileCount:int = 0;
         var fileTotal:int = copy.length;
         var onMultiLoad:Function = function(param1:int, param2:*):void
         {
            switch(int(param1) - 1)
            {
               case 0:
                  fileCount = fileCount + 1;
                  if(fileCount == fileTotal)
                  {
                     if(handle != null)
                     {
                        if((mask & 4) == 4)
                        {
                           handle(4,1,fileCount,fileTotal);
                        }
                        if((mask & 1) == 1)
                        {
                           handle(1,param2,fileCount,fileTotal);
                        }
                        handle = null;
                     }
                     break;
                  }
                  download(copy.shift(),onMultiLoad,mask,cacheFromName);
                  break;
               case 1:
                  if(handle != null)
                  {
                     if((mask & 2) == 2)
                     {
                        handle(2,param2,fileCount,fileTotal);
                     }
                  }
                  break;
               default:
                  if(handle != null)
                  {
                     if((mask & 2) == 2)
                     {
                        handle(2,param2,fileCount,fileTotal);
                     }
                  }
                  break;
               case 3:
                  if(handle != null)
                  {
                     if((mask & 4) == 4)
                     {
                        handle(4,param2,fileCount,fileTotal);
                     }
                  }
            }
         };
         download(copy.shift(),onMultiLoad,mask,cacheFromName);
      }
      
      public function downloadBy(param1:int, param2:String, param3:Function, param4:int = 7, param5:Boolean = false) : void
      {
         chan = param1;
         url = param2;
         handle = param3;
         mask = param4;
         cacheFromName = param5;
         var queue:Vector.<Download> = _channels[chan];
         if(queue == null)
         {
            queue = new Vector.<Download>();
            _channels[chan] = new Vector.<Download>();
         }
         var down:Download = new Download();
         down.url = url;
         down.handle = handle;
         down.mask = mask;
         down.cacheFromUrl = cacheFromName;
         queue.push(down);
         var onLoad:Function = function(param1:int, param2:*):void
         {
            queue[0].handle(param1,param2);
            if(param1 == 1 || param1 == 2)
            {
               queue.shift();
               if(queue.length)
               {
                  down = queue[0];
                  download(down.url,onLoad,down.mask,down.cacheFromUrl);
               }
            }
         };
         if(queue.length == 1)
         {
            download(down.url,onLoad,down.mask,down.cacheFromUrl);
         }
      }
      
      public function multiDownloadBy(param1:int, param2:Array, param3:Function, param4:int = 7, param5:Boolean = false) : void
      {
         chan = param1;
         urls = param2;
         handle = param3;
         mask = param4;
         cacheFromName = param5;
         var copy:Array = urls.concat();
         var fileCount:int = 0;
         var fileTotal:int = copy.length;
         var onMultiLoad:Function = function(param1:int, param2:*):void
         {
            switch(int(param1) - 1)
            {
               case 0:
                  fileCount = fileCount + 1;
                  if(fileCount == fileTotal)
                  {
                     if(handle != null)
                     {
                        handle(4,1,fileCount,fileTotal);
                        handle(1,param2,fileCount,fileTotal);
                        handle = null;
                     }
                     break;
                  }
                  downloadBy(chan,copy.shift(),onMultiLoad,mask,cacheFromName);
                  break;
               case 1:
                  if(handle != null)
                  {
                     handle(2,param2,fileCount,fileTotal);
                  }
                  break;
               default:
                  if(handle != null)
                  {
                     handle(2,param2,fileCount,fileTotal);
                  }
                  break;
               case 3:
                  if(handle != null)
                  {
                     handle(4,param2,fileCount,fileTotal);
                  }
            }
         };
         downloadBy(chan,copy.shift(),onMultiLoad,mask,cacheFromName);
      }
   }
}

class Download
{
    
   
   public var url:String;
   
   public var handle:Function;
   
   public var mask:int;
   
   public var cacheFromUrl:Boolean;
   
   function Download()
   {
      super();
   }
}

class Cache
{
    
   
   public var url:String;
   
   public var name:String;
   
   public var file;
   
   public var ms:int;
   
   function Cache()
   {
      super();
   }
}
