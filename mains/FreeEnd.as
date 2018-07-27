package fla.play
{
   import com.ALIB.DynamicEvent;
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.Window;
   import fla.Home;
   import fla.Rate;
   import fla.play.ui.CountDownPart;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import fls.SoundWin;
   
   public class FreeEnd extends Window
   {
       
      
      public var _title:MovieClip;
      
      public var _timeKey:TextField;
      
      public var _timeVal:TextField;
      
      public var _comboKey:TextField;
      
      public var _comboVal:TextField;
      
      public var _scoreKey:TextField;
      
      public var _scoreVal:TextField;
      
      public var _levelKey:TextField;
      
      public var _levelVal:TextField;
      
      public var _replay:Button;
      
      public var _exit:Button;
      
      public var _share:Button;
      
      public var _rate:Button;
      
      public function FreeEnd()
      {
         super();
         this.addEventListener("addedToStage",onAddedToStage);
         _replay.addEventListener(AuiDefine.CLICK,onClickReplay);
         _exit.addEventListener(AuiDefine.CLICK,onClickExit);
         _share.addEventListener(AuiDefine.CLICK,onClickShare);
         _share.visible = game.shell.shareOpen;
         _rate.addEventListener(AuiDefine.CLICK,onClickRate);
         _rate.visible = _G.player.getLevel() >= 30;
         _timeKey.text = Language.id(2013) + " =";
         _comboKey.text = Language.id(2012) + " =";
         _scoreKey.text = Language.id(2010) + " =";
         _levelKey.text = Language.id(2011) + " =";
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.removeEventListener("addedToStage",onAddedToStage);
         this.addEventListener("removedFromStage",onRemovedFromStage);
         root.dispatchEvent(new DynamicEvent("STAT_TICK","ROUND"));
         root.dispatchEvent(new DynamicEvent("ROUND"));
         _G.playBGM(new SoundWin(),1,1);
         var _loc3_:int = (PlayMain.self.ui as FreeUI)._countDownPart.getSeconds();
         var _loc2_:int = (PlayMain.self.ui as FreeUI)._comboPart.getMax();
         _timeVal.text = CountDownPart.getFormatTime(_loc3_);
         _comboVal.text = _loc2_ == 0?_loc2_.toString():_loc2_ + "(MAX)";
         var _loc5_:int = PlayMain.self.sumScore;
         var _loc4_:int = PlayMain.self.sumLevel;
         _scoreVal.htmlText = _G.player.getScore() + " <font color=\"#FFFF00\">" + (_loc5_ >= 0?"↑" + _loc5_:"↓" + _loc5_) + "</font>";
         _levelVal.htmlText = _G.player.getLevel() + " <font color=\"#FFFF00\">" + (_loc4_ >= 0?"↑" + _loc4_:"↓" + _loc4_) + "</font>";
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
         game.self.setContentView(new Home());
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
