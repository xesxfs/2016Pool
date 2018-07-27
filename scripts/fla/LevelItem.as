package fla
{
   import com.ALIB.DynamicEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class LevelItem extends Sprite
   {
      
      public static var isEn:Boolean = false;
       
      
      public var _image:MovieClip;
      
      public var _name:TextField;
      
      public var _download:MovieClip;
      
      public var _iso3166:MovieClip;
      
      public var _record:MovieClip;
      
      public var _row:Object;
      
      public var _netImage:Sprite;
      
      public function LevelItem()
      {
         super();
         this.mouseChildren = false;
         _download.mouseEnabled = false;
         _download.mouseChildren = false;
         _download.visible = false;
         _image.stop();
         _record.visible = false;
         addEventListener("added",onAdded);
      }
      
      private function onAdded(param1:Event) : void
      {
         removeEventListener("added",onAdded);
         parent.addEventListener("EN",onEn,false,0,true);
      }
      
      private function onEn(param1:DynamicEvent) : void
      {
         if(!_row)
         {
            return;
         }
         this._name.text = Language.replace(!!isEn?_row.enName:_row.name);
      }
      
      public function set value(param1:Object) : void
      {
         var _loc4_:* = null;
         if(!param1)
         {
            this.visible = false;
            return;
         }
         this.visible = true;
         _row = param1;
         this._name.text = Language.replace(!!isEn?_row.enName:_row.name);
         try
         {
            _loc4_ = _row.creatorLocale;
            _iso3166.gotoAndStop(_loc4_.split("-")[1]);
         }
         catch(e:Error)
         {
            _iso3166.gotoAndStop("UNKNOWN");
         }
         _record.visible = false;
         var _loc2_:Array = _G.player.getRecordBy(_row.id,null);
         if(_loc2_ != null && _loc2_[0] != 0)
         {
            _record.label.text = _loc2_[0];
            _record.visible = true;
         }
         var _loc3_:String = param1.imageUrl;
         if(_loc3_.indexOf("#") == 0)
         {
            _image.gotoAndStop(parseInt(_loc3_.substr(1)));
         }
         else
         {
            _image.gotoAndStop("BLANK");
            if(_netImage != null && _netImage.stage != null)
            {
               _image.removeChild(_netImage);
            }
            _netImage = _G.fc.downloadImage(_loc3_);
            _image.addChild(_netImage);
         }
      }
      
      public function set isDownload(param1:Boolean) : void
      {
         _download.visible = param1;
         if(param1)
         {
            _record.visible = false;
         }
      }
   }
}
