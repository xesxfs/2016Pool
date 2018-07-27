package fla
{
   import com.ALIB.DynamicEvent;
   import com.ALIB.Utils;
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.CloseButton;
   import com.AUI.Toast;
   import com.AUI.Window;
   import fla.play.PlayMain;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   
   public class LevelInfo extends Window
   {
       
      
      public var _title:TextField;
      
      public var _nameKey:TextField;
      
      public var _nameVal:TextField;
      
      public var _enNameKey:TextField;
      
      public var _enNameVal:TextField;
      
      public var _creatorKey:TextField;
      
      public var _creatorVal:TextField;
      
      public var _createDateKey:TextField;
      
      public var _createDateVal:TextField;
      
      public var _bestRecordKey:TextField;
      
      public var _bestRecordVal:TextField;
      
      public var _iso3166:MovieClip;
      
      public var _close:CloseButton;
      
      public var _delete:Button;
      
      public var _share:Button;
      
      public var _recommend:Button;
      
      public var _hadRecommend:MovieClip;
      
      private var _row:Object;
      
      public function LevelInfo(param1:Object)
      {
         super();
         _row = param1;
         _share.addEventListener(AuiDefine.CLICK,onClickShare);
         _share.visible = game.shell.shareOpen;
         _title.defaultTextFormat = _G.windowTitle;
         _title.text = Language.id(1000);
         _nameKey.text = Language.id(1001) + " =";
         _enNameKey.text = Language.id(1002) + " =";
         _creatorKey.text = Language.id(1003) + " =";
         _createDateKey.text = Language.id(1004) + " =";
         _bestRecordKey.text = Language.id(2015) + " =";
         if(_row.flags & 1)
         {
            _recommend.visible = !Utils.getBitAt(_row.flags,1);
            _hadRecommend.visible = !_recommend.visible;
            _delete.visible = true;
            _delete.addEventListener(AuiDefine.CLICK,onClickDelete);
            _recommend.addEventListener(AuiDefine.CLICK,onClickRecommend);
         }
         else
         {
            _recommend.visible = false;
            _hadRecommend.visible = false;
            _delete.visible = false;
         }
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         super.onAddedToStage(param1);
         var _loc2_:Array = PlayMain.self.row.record;
         var _loc3_:int = _loc2_[0];
         _bestRecordVal.text = _loc3_ == 0?"-":_loc3_ + " " + Language.id(2000);
         init();
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         super.onRemovedFromStage(param1);
      }
      
      private function onClickShare(param1:Event) : void
      {
         _share.visible = false;
         PlayMain.self._bg.visible = true;
         var _loc3_:BitmapData = new BitmapData(game.w,game.h);
         _loc3_.draw(root);
         var _loc2_:DynamicEvent = new DynamicEvent("SHARE_SHOW");
         _loc2_.body = _loc3_;
         root.dispatchEvent(_loc2_);
         _share.visible = true;
         PlayMain.self._bg.visible = false;
      }
      
      public function init() : void
      {
         var _loc1_:* = null;
         _nameVal.text = _row.name;
         _enNameVal.text = _row.enName;
         _creatorVal.text = _row.creatorName;
         _createDateVal.text = (_row.createDate as String).split(" ")[0];
         try
         {
            _loc1_ = _row.creatorLocale;
            _iso3166.gotoAndStop(_loc1_.split("-")[1]);
            return;
         }
         catch(e:Error)
         {
            _iso3166.gotoAndStop("UNKNOWN");
            return;
         }
      }
      
      private function onClickRecommend(param1:Event) : void
      {
         e = param1;
         game.hud.confirm(Language.id(1075),function(param1:Boolean):void
         {
            if(param1 == false)
            {
               return;
            }
            new URLLoader().load(new URLRequest("http://min87.com/fancy/tq9/incRcommend.php?type=0&id=" + _row.id));
            _row.flags = Utils.setBitAt(_row.flags,1,true);
            _recommend.visible = false;
            _hadRecommend.visible = true;
         });
      }
      
      private function onClickDelete(param1:Event) : void
      {
         e = param1;
         game.hud.confirm(Language.id(1061),function(param1:Boolean):void
         {
            value = param1;
            if(value == false)
            {
               return;
            }
            return;
            §§push(setTimeout(function():void
            {
               _G.player.delDownload(_row.id);
               Toast.show(Language.id(1060));
               game.self.setContentView(new ChallEntry(false,1));
            },1));
         });
      }
   }
}
