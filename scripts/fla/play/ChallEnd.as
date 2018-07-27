package fla.play
{
   import com.ALIB.DynamicEvent;
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.Window;
   import fla.ChallEntry;
   import fla.Rate;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import fls.SoundWin;
   
   public class ChallEnd extends Window
   {
       
      
      public var _title:MovieClip;
      
      public var _nameKey:TextField;
      
      public var _nameVal:TextField;
      
      public var _scoreKey:TextField;
      
      public var _scoreVal:TextField;
      
      public var _levelKey:TextField;
      
      public var _levelVal:TextField;
      
      public var _bestRecordKey:TextField;
      
      public var _bestRecordVal:TextField;
      
      public var _curRecordKey:TextField;
      
      public var _curRecordVal:TextField;
      
      public var _best:Sprite;
      
      public var _replay:Button;
      
      public var _exit:Button;
      
      public var _share:Button;
      
      public var _rate:Button;
      
      public function ChallEnd()
      {
         super();
         this.addEventListener("addedToStage",onAddedToStage);
         _replay.addEventListener(AuiDefine.CLICK,onClickReplay);
         _exit.addEventListener(AuiDefine.CLICK,onClickExit);
         _best.visible = false;
         _share.addEventListener(AuiDefine.CLICK,onClickShare);
         _share.visible = game.shell.shareOpen;
         _rate.addEventListener(AuiDefine.CLICK,onClickRate);
         _rate.visible = _G.player.getLevel() >= 30;
         _nameKey.text = Language.id(2009) + " =";
         _scoreKey.text = Language.id(2010) + " =";
         _levelKey.text = Language.id(2011) + " =";
         _bestRecordKey.text = Language.id(2015) + " =";
         _curRecordKey.text = Language.id(2016) + " =";
         _title.gotoAndStop(Language.field);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.removeEventListener("addedToStage",onAddedToStage);
         this.addEventListener("removedFromStage",onRemovedFromStage);
         _nameVal.text = (PlayMain.self.ui as ChallUI)._labelPart.data;
         var _loc2_:Array = PlayMain.self.row.record;
         var _loc6_:int = _loc2_[0];
         var _loc5_:int = (PlayMain.self.ui as ChallUI)._shotPart.getUsed();
         _best.visible = _loc6_ != 0 && _loc5_ < _loc6_;
         _curRecordVal.text = _loc5_ + " " + Language.id(2000);
         _bestRecordVal.text = _loc6_ == 0?"-":_loc6_ + " " + Language.id(2000);
         root.dispatchEvent(new DynamicEvent("STAT_TICK","ROUND"));
         root.dispatchEvent(new DynamicEvent("ROUND"));
         _G.playBGM(new SoundWin(),1,1);
         if(_loc5_ < _loc6_ || _loc6_ == 0)
         {
            _loc2_[0] = _loc5_;
         }
         var _loc4_:int = PlayMain.self.sumScore;
         var _loc3_:int = PlayMain.self.sumLevel;
         _scoreVal.htmlText = _G.player.getScore() + " <font color=\"#FFFF00\">" + (_loc4_ >= 0?"↑" + _loc4_:"↓" + _loc4_) + "</font>";
         _levelVal.htmlText = _G.player.getLevel() + " <font color=\"#FFFF00\">" + (_loc3_ >= 0?"↑" + _loc3_:"↓" + _loc3_) + "</font>";
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         _G.playBGMUrl(game.shell.bgmUrl);
      }
      
      private function onClickReplay(param1:Event) : void
      {
         e = param1;
         game.hud.removeChildren();
      }
      
      private function onClickExit(param1:Event) : void
      {
         game.hud.removeChildren();
         game.self.setContentView(new ChallEntry());
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
      
      private function onClickRate(param1:Event) : void
      {
         game.hud.addToCenter(new Rate());
      }
   }
}
