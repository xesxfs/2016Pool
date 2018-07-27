package fla
{
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.CloseButton;
   import com.AUI.Toast;
   import com.AUI.Window;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.text.TextField;
   
   public class DownloadInfo extends Window
   {
       
      
      public var _title:TextField;
      
      public var _image:MovieClip;
      
      public var _shotField:TextField;
      
      public var _nameKey:TextField;
      
      public var _nameVal:TextField;
      
      public var _enNameKey:TextField;
      
      public var _enNameVal:TextField;
      
      public var _creatorKey:TextField;
      
      public var _creatorVal:TextField;
      
      public var _createDateKey:TextField;
      
      public var _createDateVal:TextField;
      
      public var _recommendKey:TextField;
      
      public var _recommendVal:TextField;
      
      public var _downloadKey:TextField;
      
      public var _downloadVal:TextField;
      
      public var _hasDownloaded:TextField;
      
      public var _done:Button;
      
      public var _close:CloseButton;
      
      public var _iso3166:MovieClip;
      
      private var _row:Object;
      
      private var _item:LevelItem;
      
      public function DownloadInfo(param1:LevelItem)
      {
         var _loc2_:* = null;
         super();
         _item = param1;
         _row = _item._row;
         _hasDownloaded.visible = false;
         _done.visible = false;
         _done.visible = false;
         _title.defaultTextFormat = _G.windowTitle;
         _image.gotoAndStop("BLANK");
         _image.addChild(_G.fc.downloadImage(_row.imageUrl));
         _title.text = Language.id(1000);
         _nameKey.text = Language.id(1001) + " =";
         _enNameKey.text = Language.id(1002) + " =";
         _creatorKey.text = Language.id(1003) + " =";
         _createDateKey.text = Language.id(1004) + " =";
         _recommendKey.text = Language.id(1050) + " =";
         _downloadKey.text = Language.id(1051) + " =";
         _shotField.text = Language.id(1040);
         _nameVal.text = "";
         _enNameVal.text = "";
         _creatorVal.text = "";
         _createDateVal.text = "";
         _recommendVal.text = "";
         _downloadVal.text = "";
         _hasDownloaded.text = Language.id(1043);
         try
         {
            _loc2_ = _row.creatorLocale;
            _iso3166.gotoAndStop(_loc2_.split("-")[1]);
         }
         catch(e:Error)
         {
            _iso3166.gotoAndStop("UNKNOWN");
         }
         _done.addEventListener(AuiDefine.CLICK,onClickDone);
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         super.onAddedToStage(param1);
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener("complete",onLoadLevel);
         _loc2_.addEventListener("ioError",onLoadLevel);
         _loc2_.addEventListener("securityError",onLoadLevel);
         _loc2_.load(new URLRequest("http://min87.com/fancy/tq9/getLevel.php?type=0&id=" + _row.id));
      }
      
      private function onLoadLevel(param1:Event) : void
      {
         if(param1.type != "complete")
         {
            return;
         }
         var _loc4_:URLLoader = param1.target as URLLoader;
         var _loc5_:String = _loc4_.data;
         var _loc3_:Array = _loc5_.split("\x01");
         _row.id = parseInt(_loc3_[0]);
         _row.layout = (_loc3_[1] as String).split(",");
         _row.shots = parseInt(_loc3_[2]);
         _row.creatorName = _loc3_[3];
         _row.createDate = _loc3_[4];
         _row.recommends = parseInt(_loc3_[5]);
         _row.downloads = parseInt(_loc3_[6]);
         _row.record = _G.fc.csv.selectObjectA("gameLevels",1).record;
         _shotField.text = Language.id(1052) + " = " + _row.shots;
         _nameVal.text = _row.name;
         _enNameVal.text = _row.enName;
         _creatorVal.text = _row.creatorName;
         _createDateVal.text = (_row.createDate as String).split(" ").shift();
         _recommendVal.text = _row.recommends;
         _downloadVal.text = _row.downloads;
         var _loc2_:* = _G.player.indexOfDownload(_row.id) != -1;
         if(_loc2_ == false)
         {
            _done.visible = true;
         }
         else
         {
            _hasDownloaded.visible = true;
         }
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         super.onRemovedFromStage(param1);
      }
      
      private function onClickDone(param1:Event) : void
      {
         new URLLoader().load(new URLRequest("http://min87.com/fancy/tq9/incDownolad.php?type=0&id=" + _row.id));
         _G.player.addDownload(_row);
         close();
         Toast.show(Language.replace(Language.id(1042)));
         _item.isDownload = true;
      }
   }
}
