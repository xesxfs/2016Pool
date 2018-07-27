package fla
{
   import com.ALIB.DynamicEvent;
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.HContainer;
   import com.AUI.MessageBox;
   import com.AUI.Radio;
   import com.AUI.ToggleButton;
   import com.AUI.event.RadioEvent;
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.setTimeout;
   
   public class Market extends Sprite
   {
      
      private static var _pageSetIndex:int = 0;
      
      private static var _pageIndex:int = 0;
      
      private static var _type:int = 0;
       
      
      public var _back:Button;
      
      public var _downloadGame:Button;
      
      public var _heads:HContainer;
      
      public var _items:MovieClip;
      
      public var _pageDec:Button;
      
      public var _pages:MovieClip;
      
      public var _pageInc:Button;
      
      public var _en:ToggleButton;
      
      public var _progressBar:Sprite;
      
      public var _bg:Sprite;
      
      private var _request:URLLoader;
      
      private var _numPages:int;
      
      private var _pagesX:int;
      
      public function Market()
      {
         _request = new URLLoader();
         super();
         _heads.autoFitHeight = true;
         _heads.autoFitWidth = true;
         _heads.itemGap = 1;
         _heads.addEventListener("radioChange",onChangeHeads);
         _back.addEventListener(AuiDefine.CLICK,onClickBack);
         _downloadGame.addEventListener(AuiDefine.CLICK,onClickDownloadGame);
         _items.mouseEnabled = false;
         _items.addEventListener(AuiDefine.CLICK,onClickItems);
         _en.addEventListener(AuiDefine.CLICK,onClickEn);
         _downloadGame.labelField = Language.field;
         _pagesX = _pages.x;
         _pages.mouseEnabled = false;
         _pages.addEventListener(AuiDefine.CLICK,onClickPages);
         _pageDec.addEventListener(AuiDefine.CLICK,onTurnPages);
         _pageInc.addEventListener(AuiDefine.CLICK,onTurnPages);
         _progressBar = new Sprite();
         _progressBar.graphics.beginFill(255);
         _progressBar.graphics.drawRect(0,0,1,4);
         _progressBar.visible = false;
         _progressBar.y = 48;
         addChild(_progressBar);
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function showElements(param1:Boolean) : void
      {
         _heads.visible = param1;
         _back.visible = param1;
         _items.visible = param1;
         _pageDec.visible = param1;
         _pageInc.visible = param1;
         _pages.visible = param1;
         _downloadGame.visible = param1;
         _en.visible = param1;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         addEventListener("removedFromStage",onRemovedFromStage);
         var _loc2_:DynamicEvent = new DynamicEvent("CHANGE_BG");
         _loc2_.body = _bg;
         root.dispatchEvent(_loc2_);
         _request.load(new URLRequest("http://min87.com/fancy/tq9/getHeads.php?lang=" + Language.field));
         _request.addEventListener("complete",onLoadHead);
         _request.addEventListener("ioError",onLoadHead);
         _request.addEventListener("securityError",onLoadHead);
         showElements(false);
         game.hud.addToCenter(new MessageBox(Language.id(1040)));
         _en.checked = _G.player.getFlagAt(1);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         removeEventListener("removedFromStage",onRemovedFromStage);
      }
      
      private function onClickBack(param1:Event = null) : void
      {
         e = param1;
      }
      
      private function onClickDownloadGame(param1:Event) : void
      {
         game.self.setContentView(new ChallEntry(false,1));
      }
      
      private function onLoadHead(param1:Event) : void
      {
         if(param1.type != "complete")
         {
            game.hud.removeChildren();
            game.hud.alert(Language.id(1041),onClickBack);
            return;
         }
         var _loc2_:String = _request.data;
         _request.removeEventListener("complete",onLoadHead);
         _request.removeEventListener("ioError",onLoadHead);
         _request.removeEventListener("securityError",onLoadHead);
         updateTabs(_loc2_.split("\x01"));
         _request.addEventListener("complete",onLoadLevels);
         _request.addEventListener("ioError",onLoadLevels);
         _request.addEventListener("securityError",onLoadLevels);
         _heads.visible = true;
         (_heads.getItemAt(_type) as Radio).checked = true;
      }
      
      private function getLevelsBy(param1:int, param2:int) : void
      {
         TweenMax.killTweensOf(_progressBar);
         _progressBar.visible = true;
         _progressBar.width = 1;
         _type = param1;
         _pageIndex = param2;
         var _loc3_:String = "http://min87.com/fancy/tq9/getLevelArray.php?type=" + _type + "&page=" + (_pageIndex + 1);
         _request.close();
         _request.load(new URLRequest(_loc3_));
         TweenMax.to(_progressBar,8,{
            "width":game.w,
            "yoyo":true,
            "repeat":2147483647
         });
      }
      
      private function onLoadLevels(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         TweenMax.killTweensOf(_progressBar);
         _progressBar.visible = false;
         if(param1.type != "complete")
         {
            game.hud.removeChildren();
            game.hud.alert(Language.id(1041),onClickBack);
            return;
         }
         this.showElements(true);
         game.hud.removeChildren();
         var _loc3_:String = _request.data;
         var _loc7_:Array = _loc3_.split("\x02");
         _numPages = parseInt(_loc7_.pop());
         _loc6_ = 0;
         _loc5_ = _loc7_.length;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = (_loc7_[_loc6_] as String).split("\x01");
            _loc4_ = {
               "id":parseInt(_loc2_[0]),
               "name":_loc2_[1],
               "enName":_loc2_[2],
               "imageUrl":_loc2_[3],
               "creatorLocale":_loc2_[4],
               "flags":parseInt(_loc2_[5])
            };
            _loc7_[_loc6_] = _loc4_;
            _loc6_++;
         }
         updatePageCtrls();
         updatePageViewBy(_loc7_);
      }
      
      private function updateTabs(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc4_ = 0;
         _loc3_ = param1.length;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new LevelHead();
            _loc2_.number = 255;
            _loc2_.data = param1[_loc4_];
            _loc2_.index = _loc4_;
            _heads.addItem(_loc2_);
            _loc4_++;
         }
         _heads.x = int((game.w - _heads.width) / 2);
      }
      
      private function updatePageViewBy(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         _loc5_ = 0;
         _loc4_ = _items.numChildren;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _items.getChildAt(_loc5_) as LevelItem;
            _loc3_ = param1[_loc5_];
            _loc2_.value = _loc3_;
            if(_loc3_)
            {
               _loc2_.isDownload = _G.player.indexOfDownload(_loc3_.id) != -1;
            }
            _loc5_++;
         }
      }
      
      private function onClickPages(param1:Event) : void
      {
         var _loc2_:int = parseInt((param1.target as Button).data) - 1;
         getLevelsBy(_type,_loc2_);
      }
      
      private function onTurnPages(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = param1.target == _pageDec?-1:1;
         }
         _pageSetIndex = _pageSetIndex + _loc2_;
         updatePageCtrls();
      }
      
      private function updatePageCtrls() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _pageDec.visible = _pageSetIndex != 0;
         _pageInc.visible = (_pageSetIndex + 1) * _pages.numChildren < _numPages;
         _loc6_ = 0;
         _loc5_ = _pages.numChildren;
         _pages.numChildren;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _pages.getChildAt(_loc6_) as Radio;
            _loc2_ = _pageSetIndex * _pages.numChildren + _loc6_;
            _loc1_ = _loc3_.width;
            _loc3_.data = (_loc2_ + 1).toString();
            _loc3_.number = 1;
            _loc3_.checked = _pageIndex == _loc2_;
            _loc3_.visible = _loc2_ < _numPages;
            if(_loc3_.visible)
            {
               _loc4_++;
            }
            _loc6_++;
         }
         if(_pageSetIndex == 0)
         {
            _loc1_ = _pages.getChildAt(0).width;
            _pages.x = _pagesX + int((_pages.width - _loc4_ * _loc1_) / 2);
         }
      }
      
      private function onChangeHeads(param1:RadioEvent) : void
      {
         getLevelsBy(param1.value.index,0);
      }
      
      private function onClickItems(param1:Event) : void
      {
         var _loc2_:LevelItem = param1.target as LevelItem;
         game.hud.addToCenter(new DownloadInfo(_loc2_));
      }
      
      private function onClickEn(param1:Event) : void
      {
         _G.player.setFlag(1,_en.checked);
         LevelItem.isEn = _en.checked;
         var _loc2_:DynamicEvent = new DynamicEvent("EN");
         _items.dispatchEvent(_loc2_);
      }
   }
}
