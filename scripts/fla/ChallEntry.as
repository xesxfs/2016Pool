package fla
{
   import com.ALIB.DynamicEvent;
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.HContainer;
   import com.AUI.Radio;
   import com.AUI.Toast;
   import com.AUI.ToggleButton;
   import com.AUI.Window;
   import com.AUI.event.RadioEvent;
   import fla.play.ChallMain;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ChallEntry extends Window
   {
      
      private static var _pageSetIndex:int = 0;
      
      private static var _pageIndex:int = 0;
      
      private static var _type:int = 0;
       
      
      public var _back:Button;
      
      public var _market:Button;
      
      public var _pageDec:Button;
      
      public var _pages:MovieClip;
      
      public var _pageInc:Button;
      
      public var _heads:HContainer;
      
      public var _items:MovieClip;
      
      public var _en:ToggleButton;
      
      public var _bg:Sprite;
      
      public var _share:Button;
      
      private var _numPages:int;
      
      private var _pagesX:int;
      
      private var _recent:Boolean;
      
      public function ChallEntry(param1:Boolean = false, param2:int = -1)
      {
         recent = param1;
         destType = param2;
         super();
         _heads.autoFitHeight = true;
         _heads.autoFitWidth = true;
         _heads.itemGap = 1;
         _heads.addEventListener("radioChange",onChangeHeads);
         _share.addEventListener(AuiDefine.CLICK,onClickShare);
         _share.visible = game.shell.shareOpen;
         _back.addEventListener(AuiDefine.CLICK,function(param1:Event):void
         {
            game.self.setContentView(new Home());
         });
         _market.addEventListener(AuiDefine.CLICK,onClickGotoMarket);
         _market.labelField = Language.field;
         _items.mouseEnabled = false;
         _items.addEventListener(AuiDefine.CLICK,onClickItems);
         _en.addEventListener("change",onClickEn);
         _pagesX = _pages.x;
         _pages.mouseEnabled = false;
         _pages.addEventListener(AuiDefine.CLICK,onClickPages);
         _pageDec.addEventListener(AuiDefine.CLICK,onTurnPages);
         _pageInc.addEventListener(AuiDefine.CLICK,onTurnPages);
         _recent = recent;
         if(_recent == false)
         {
            _pageSetIndex = 0;
            _pageIndex = 0;
         }
         if(destType != -1)
         {
            _type = destType;
         }
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         var _loc2_:DynamicEvent = new DynamicEvent("CHANGE_BG");
         _loc2_.body = _bg;
         root.dispatchEvent(_loc2_);
         updateTabs();
         _en.checked = _G.player.getFlagAt(1);
         (_heads.getItemAt(_type) as Radio).checked = true;
         if(_G.player.getStep() <= 1)
         {
            _G.shineObject(_items.getChildAt(0));
            _G.player.setStep(2);
         }
      }
      
      private function onClickGotoMarket(param1:Event) : void
      {
         game.self.setContentView(new Market());
      }
      
      private function getLevelsBy(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         _type = param1;
         _pageIndex = param2;
         if(_type == 0)
         {
            _loc3_ = _G.fc.csv.selectAllArray("gameLevels");
         }
         else
         {
            _loc3_ = _G.player.model.downloads;
         }
         this._numPages = Math.ceil(_loc3_.length / _items.numChildren);
         updatePageCtrls();
         updatePageViewBy(_loc3_);
      }
      
      private function updateTabs() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc4_:Array = [1020,1021];
         _loc3_ = 0;
         _loc2_ = _loc4_.length;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new LevelHead();
            _loc1_.number = 255;
            _loc1_.data = Language.id(_loc4_[_loc3_]);
            _loc1_.index = _loc3_;
            _heads.addItem(_loc1_);
            _loc3_++;
         }
         _heads.x = int((game.w - _heads.width) / 2);
      }
      
      private function updatePageViewBy(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         _loc6_ = 0;
         _loc5_ = _items.numChildren;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _items.getChildAt(_loc6_) as LevelItem;
            _loc2_ = _pageIndex * _loc5_ + _loc6_;
            _loc4_ = param1[_loc2_];
            _loc3_.value = _loc4_;
            _loc6_++;
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
         if(_numPages == 0)
         {
            Toast.show(Language.id(1022),1.2);
         }
         _en.visible = _numPages != 0;
         _pages.visible = _numPages != 0;
         _pageDec.visible = _pageSetIndex != 0;
         _pageInc.visible = (_pageSetIndex + 1) * _pages.numChildren < _numPages;
         _loc6_ = 0;
         _loc5_ = _pages.numChildren;
         _pages.numChildren;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _pages.getChildAt(_loc6_) as Radio;
            _loc2_ = _pageSetIndex * _pages.numChildren + _loc6_;
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
         var _loc2_:int = 0;
         if(_recent == true)
         {
            _recent = false;
            _loc2_ = _pageIndex;
         }
         getLevelsBy(param1.value.index,_loc2_);
      }
      
      private function onClickItems(param1:Event) : void
      {
         _G.playTick();
         var _loc3_:LevelItem = param1.target as LevelItem;
         var _loc2_:Object = _loc3_._row;
         game.self.setContentView(new ChallMain(_loc2_));
      }
      
      private function onClickShare(param1:Event) : void
      {
         _share.visible = false;
         _bg.visible = true;
         var _loc3_:BitmapData = new BitmapData(game.w,game.h);
         _loc3_.draw(root);
         var _loc2_:DynamicEvent = new DynamicEvent("SHARE_SHOW");
         _loc2_.body = _loc3_;
         root.dispatchEvent(_loc2_);
         _share.visible = true;
         _bg.visible = false;
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
